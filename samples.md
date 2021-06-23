
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


Search for events : 

{events(filter: {locationContains: "Omer"}) {
  name
  remainingSeats
}}
{events(filter: {userIdEquals: 1}) {
  name
  location
}}
{events(filter: {typeContains: "Office"}) {
  name
  remainingSeats
}}
{events(filter: {dateEquals: 1624379395}) {
  name
  remainingSeats
}}


Log in user : 

mutation signIn {
  signIn(email: "coinhouse-darline1@coinhouse.fr",password: "password"){
    user{
      name
      email
      
    }
    token
    errors
  }
  
}

Add attendee to existing event : 

mutation addAttendee {
  addAttendee(input: {eventId: 22}){
    attendee{
      event{
        location
      }
      user{
          name
      }
    }    
    errors
  }  
}
