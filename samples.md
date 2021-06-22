
Create an event: 

mutation addEvent {
  addEvent(
    input:{
      userId: 1, 
      type: "OfficeHour", 
      description: "random description", 
      location: "random location", 
      name: "Fancy name", 
      happensOn: 1624379395, 
      startsAt: 1624379395, 
      endsAt: 1624379395
    }) {

    event{
      name
      startsAt
    }
    errors
  }
}


Search for events: 

{events(filter: {locationContains: "Omer"}) {
  name
}}
{events(filter: {userIdEquals: 1}) {
  name
}}
{events(filter: {typeContains: "Office"}) {
  name
}}
{events(filter: {dateEquals: 1624379395}) {
  name
}}
