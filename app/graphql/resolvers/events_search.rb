require 'search_object'
require 'search_object/plugin/graphql'

class Resolvers::EventsSearch < GraphQL::Schema::Resolver
  include SearchObject.module(:graphql)

  scope { Event.all }

  type [Types::EventType]

  class EventFilter < ::Types::BaseInputObject
    argument :OR, [self], required: false
    argument :type_contains, String, required: false
    argument :location_contains, String, required: false
    argument :user_id_equals, Integer, required: false
    argument :date_equals, Integer, required: false
  end

  class EventOrderBy < ::Types::BaseEnum
    value 'createdAt_ASC'
    value 'createdAt_DESC'
  end

  option :filter, type: EventFilter, with: :apply_filter
  option :first, type: types.Int, with: :apply_first
  option :skip, type: types.Int, with: :apply_skip
  option :orderBy, type: EventOrderBy, default: 'createdAt_DESC'

  def apply_filter(scope, value)
    branches = normalize_filters(value).reduce { |a, b| a.or(b) }
    scope.merge branches
  end

  def normalize_filters(value, branches = [])
    scope = Event.all
    scope = scope.where('type LIKE ?', "%#{value[:type_contains]}%") if value[:type_contains]
    scope = scope.where('location LIKE ?', "%#{value[:location_contains]}%") if value[:location_contains]
    scope = scope.where('happens_on = ?', Time.at(value[:date_equals])) if value[:date_equals]
    scope = scope.where('user_id = ?', value[:user_id_equals]) if value[:user_id_equals]

    branches << scope

    value[:OR].reduce(branches) { |s, v| normalize_filters(v, s) } if value[:OR].present?

    branches
  end

  def apply_first(scope, value)
    scope.limit(value)
  end

  def apply_skip(scope, value)
    scope.offset(value)
  end

  def apply_order_by_with_created_at_asc(scope)
    scope.order('created_at ASC')
  end

  def apply_order_by_with_created_at_desc(scope)
    scope.order('created_at DESC')
  end

end

