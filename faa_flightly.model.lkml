connection: "red_flight"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"



explore: flights {
  join: airports {
    relationship: many_to_one
    type: inner
    sql_on: ${flights.origin}=${airports.code};;
  }
  join: flights_fact {
    relationship: many_to_one
    type: inner
    sql_on: ${flights.tail_num} = ${flights_fact.tail_num};;
    }
}
# explore: accidents {}
#
# explore: aircraft {}
#
# explore: aircraft_models {}
#
# explore: airports {}
#
# explore: cal454 {}
#
# explore: carriers {}

# explore: flights_by_day {}
#
# explore: ontime {}
#
# explore: temp2 {}
