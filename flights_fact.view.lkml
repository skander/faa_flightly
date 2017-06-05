view: flights_fact {
  derived_table: {
    sql: select
      tail_num,
      count(*)
      from public.flights
      group by tail_num
       ;;
  }

  dimension: tail_num {
    type: string
    hidden: yes
    sql: ${TABLE}.tail_num ;;
  }

  dimension: total_flights {
    type: number
    sql: ${TABLE}.count ;;
  }
  dimension: flight_segment {
    type: tier
    tiers: [10,500,1000,5000,10000]
    style: integer
    sql: ${total_flights} ;;
  }

  set: detail {
    fields: [tail_num, total_flights]
  }
}
