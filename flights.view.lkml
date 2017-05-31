view: flights {
  sql_table_name: public.flights ;;

  dimension: arr_delay {
    type: number
    sql: ${TABLE}.arr_delay ;;
  }

  dimension_group: arr {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.arr_time ;;
  }

  dimension: cancelled {
    type: string
    sql: ${TABLE}.cancelled ;;
  }

  dimension: carrier {
    type: string
    sql: ${TABLE}.carrier ;;
  }

  dimension: dep_delay {
    type: number
    sql: ${TABLE}.dep_delay ;;
  }
  dimension: delay_status {
    case: {
      when: {
        sql:${dep_delay} <= 15 ;;
        label: "On time"
      }
      when: {
        sql: ${dep_delay} > 15 and ${dep_delay} <= 60  ;;
        label: "Late"
      }
      when: {
        sql: ${dep_delay} > 60 ;;
        label: "Very late"
      }
      else: "unknown"
    }

  }


  dimension_group: dep {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.dep_time ;;
  }

  dimension: destination {
    type: string
    sql: ${TABLE}.destination ;;
  }

  dimension: distance {
    type: number
    sql: ${TABLE}.distance ;;
  }

  dimension: diverted {
    type: string
    sql: ${TABLE}.diverted ;;
  }

  dimension: flight_num {
    type: string
    sql: ${TABLE}.flight_num ;;
  }

  dimension: flight_time {
    type: number
    sql: ${TABLE}.flight_time ;;
  }

  dimension: id2 {
    type: number
    sql: ${TABLE}.id2 ;;
  }

  dimension: origin {
    type: string
    sql: ${TABLE}.origin ;;
  }

  dimension: tail_num {
    type: string
    sql: ${TABLE}.tail_num ;;
  }

  dimension: taxi_in {
    type: number
    sql: ${TABLE}.taxi_in ;;
  }

  dimension: taxi_out {
    type: number
    sql: ${TABLE}.taxi_out ;;
  }
  ##Late flight only##
  measure: total_flight_late {
    type: count
    filters: {
      field: delay_status
      value: "Late"
    }
  }

  measure: percent_late {
    type: number
    value_format_name: percent_2
    sql: 1.0 * ${total_flight_late}/NULLIF(${count},0) ;;
  }
   ##Percentage very Late flight only##
  measure: total_flight_verylate {
    type: count
    filters: {
      field: delay_status
      value: "Very late"
    }
  }

  measure: percent_verylate {
    type: number
    value_format_name: percent_2
    sql: 1.0 * ${total_flight_verylate}/NULLIF(${count},0) ;;
  }
##Percentage on time flight only##
  measure: total_flight_ontime {
    type: count
    filters: {
      field: delay_status
      value: "On time"
    }
  }

  measure: percent_ontime {
    type: number
    value_format_name: percent_2
    sql: 1.0 * ${total_flight_ontime}/NULLIF(${count},0) ;;
  }


  measure: count {
    type: count
    drill_fields: []
  }
}
