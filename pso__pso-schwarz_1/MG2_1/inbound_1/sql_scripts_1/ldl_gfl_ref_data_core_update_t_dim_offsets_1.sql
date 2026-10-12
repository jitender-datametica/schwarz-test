-- Calendar_1 Year
 merge
  into core_dim.t_dim_calendar_year_1 n
 using(select b.cal_year,
              case when b.cal_year = c.cal_year then true else false end as curr_cal_year_fg,
              b.cal_year - c.cal_year as cal_year_offset
         from core_dim.t_dim_calendar_year_1 b
        cross
         join(select cal_year
                from core_dim.t_dim_calendar_year_1
               where current_date between cal_year_begin_dt and cal_year_end_dt
             ) c
        where b.cal_year != -1
      ) o
    on(n.cal_year = o.cal_year)
    when matched 
        and
        (
            not equal_null(n.curr_cal_year_fg, o.curr_cal_year_fg) 
            or not equal_null(n.cal_year_offset, o.cal_year_offset)
        )
    then update 
        set n.curr_cal_year_fg = o.curr_cal_year_fg,
           n.cal_year_offset = o.cal_year_offset,
           n.dwh_updated_tmsp = current_timestamp(),
           n.dwh_load_id = ${LOAD_ID},
           n.dwh_node_cd = 'MANUAL'
;  

-- Business Year
 merge
  into core_dim.t_dim_business_year_1 n
 using(select b.bus_year,
              case when b.bus_year = c.bus_year then true else false end as curr_bus_year_fg,
              b.bus_year - c.bus_year as bus_year_offset
         from core_dim.t_dim_business_year_1 b
        cross
         join(select bus_year
                from core_dim.t_dim_business_year_1
               where current_date between bus_year_begin_dt and bus_year_end_dt
             ) c
        where b.bus_year != -1
      ) o
    on(n.bus_year = o.bus_year)
  when matched
       and
      (
        not equal_null(n.curr_bus_year_fg, o.curr_bus_year_fg)
        or not equal_null(n.bus_year_offset, o.bus_year_offset)
      )  
  then update 
      set n.curr_bus_year_fg = o.curr_bus_year_fg,
          n.bus_year_offset = o.bus_year_offset,
          n.dwh_updated_tmsp = current_timestamp(),
          n.dwh_load_id = ${LOAD_ID},
          n.dwh_node_cd = 'MANUAL'
;  

-- Calendar_1 Half Year
 merge
  into core_dim.t_dim_calendar_half_year_1 n
 using(select b.cal_half_year,
              case when b.cal_half_year = c.cal_half_year then true else false end as curr_cal_half_year_fg,
              dense_rank() over (order by b.cal_year) - c.offset_year as cal_year_offset,
              dense_rank() over (order by b.cal_half_year) - c.offset_half_year as cal_half_year_offset
         from core_dim.t_dim_calendar_half_year_1 b
        cross
         join(select cal_half_year,
                     offset_year,
                     offset_half_year
                from(select cal_half_year,
                            cal_half_year_begin_dt,
                            cal_half_year_end_dt,
                            dense_rank() over (order by cal_half_year) as offset_half_year,
                            dense_rank() over (order by cal_year) as offset_year
                       from core_dim.t_dim_calendar_half_year_1
                      where cal_half_year != -1
                    )
               where current_date between cal_half_year_begin_dt and cal_half_year_end_dt
             ) c
        where b.cal_half_year != -1
      ) o
    on(n.cal_half_year = o.cal_half_year)
  when matched 
        and
        (
          not equal_null(n.curr_cal_half_year_fg, o.curr_cal_half_year_fg)
          or not equal_null(n.cal_year_offset, o.cal_year_offset)
          or not equal_null(n.cal_half_year_offset, o.cal_half_year_offset)
        )
  then update 
      set n.curr_cal_half_year_fg = o.curr_cal_half_year_fg,
          n.cal_year_offset = o.cal_year_offset,
          n.cal_half_year_offset = o.cal_half_year_offset,
          n.dwh_updated_tmsp = current_timestamp(),
          n.dwh_load_id = ${LOAD_ID},
          n.dwh_node_cd = 'MANUAL'
;  

-- Business Half Year
 merge
  into core_dim.t_dim_business_half_year_1 n
 using(select b.bus_half_year,
              case when b.bus_half_year = c.bus_half_year then true else false end as curr_bus_half_year_fg,
              dense_rank() over (order by b.bus_year) - c.offset_year as bus_year_offset,
              dense_rank() over (order by b.bus_half_year) - c.offset_half_year as bus_half_year_offset
         from core_dim.t_dim_business_half_year_1 b
        cross
         join(select bus_half_year,
                     offset_half_year,
                     offset_year
                from(select bus_half_year,
                            bus_half_year_begin_dt,
                            bus_half_year_end_dt,
                            dense_rank() over (order by bus_half_year) as offset_half_year,
                            dense_rank() over (order by bus_year) as offset_year
                       from core_dim.t_dim_business_half_year_1
                      where bus_half_year != -1
                    )
               where current_date between bus_half_year_begin_dt and bus_half_year_end_dt
             ) c
        where b.bus_half_year != -1
      ) o
    on(n.bus_half_year = o.bus_half_year)
  when matched
      and
      (
        not equal_null(n.curr_bus_half_year_fg, o.curr_bus_half_year_fg)
        or not equal_null(n.bus_year_offset, o.bus_year_offset)
        or not equal_null(n.bus_half_year_offset, o.bus_half_year_offset)
      )
  then update 
      set n.curr_bus_half_year_fg = o.curr_bus_half_year_fg,
          n.bus_year_offset = o.bus_year_offset,
          n.bus_half_year_offset = o.bus_half_year_offset,
          n.dwh_updated_tmsp = current_timestamp(),
          n.dwh_load_id = ${LOAD_ID},
          n.dwh_node_cd = 'MANUAL'
;  

-- Calendar_1 Year Quarter
 merge
  into core_dim.t_dim_calendar_year_quarter_1 n
 using(select b.cal_year_qtr,
              case when b.cal_year_qtr = c.cal_year_qtr then true else false end as curr_cal_year_qtr_fg,
              dense_rank() over (order by b.cal_year) - c.offset_year as cal_year_offset,
              dense_rank() over (order by b.cal_half_year) - c.offset_half_year as cal_half_year_offset,
              dense_rank() over (order by b.cal_year_qtr) - c.offset_year_qtr as cal_year_qtr_offset
         from core_dim.t_dim_calendar_year_quarter_1 b
        cross
         join(select cal_year_qtr,
                     offset_year_qtr,
                     offset_half_year,
                     offset_year
                from(select cal_year_qtr,
                            cal_year_qtr_begin_dt,
                            cal_year_qtr_end_dt,
                            dense_rank() over (order by cal_year_qtr) as offset_year_qtr,
                            dense_rank() over (order by cal_half_year) as offset_half_year,
                            dense_rank() over (order by cal_year) as offset_year
                       from core_dim.t_dim_calendar_year_quarter_1
                      where cal_year_qtr != -1
                    )
               where current_date between cal_year_qtr_begin_dt and cal_year_qtr_end_dt
             ) c
        where b.cal_year_qtr != -1
      ) o
    on(n.cal_year_qtr = o.cal_year_qtr)
  when matched 
      and
      (
        not equal_null(n.curr_cal_year_qtr_fg, o.curr_cal_year_qtr_fg)
        or not equal_null(n.cal_year_offset, o.cal_year_offset)
        or not equal_null(n.cal_half_year_offset, o.cal_half_year_offset)
        or not equal_null(n.cal_year_qtr_offset, o.cal_year_qtr_offset)
      )
  then update 
      set n.curr_cal_year_qtr_fg = o.curr_cal_year_qtr_fg,
          n.cal_year_offset = o.cal_year_offset,
          n.cal_half_year_offset = o.cal_half_year_offset,
          n.cal_year_qtr_offset = o.cal_year_qtr_offset,
          n.dwh_updated_tmsp = current_timestamp(),
          n.dwh_load_id = ${LOAD_ID},
          n.dwh_node_cd = 'MANUAL'
;

-- Business Year Quarter
 merge
  into core_dim.t_dim_business_year_quarter_1 n
 using(select b.bus_year_qtr,
              case when b.bus_year_qtr = c.bus_year_qtr then true else false end as curr_bus_year_qtr_fg,
              dense_rank() over (order by b.bus_year) - c.offset_year as bus_year_offset,
              dense_rank() over (order by b.bus_half_year) - c.offset_half_year as bus_half_year_offset,
              dense_rank() over (order by b.bus_year_qtr) - c.offset_year_qtr as bus_year_qtr_offset
         from core_dim.t_dim_business_year_quarter_1 b
        cross
         join(select bus_year_qtr,
                     offset_year,
                     offset_half_year,
                     offset_year_qtr
                from(select bus_year_qtr,
                            bus_year_qtr_begin_dt,
                            bus_year_qtr_end_dt,
                            dense_rank() over (order by bus_year_qtr) as offset_year_qtr,
                            dense_rank() over (order by bus_half_year) as offset_half_year,
                            dense_rank() over (order by bus_year) as offset_year
                       from core_dim.t_dim_business_year_quarter_1
                      where bus_year_qtr != -1
                    )
               where current_date between bus_year_qtr_begin_dt and bus_year_qtr_end_dt
             ) c
        where b.bus_year_qtr != -1
      ) o
    on(n.bus_year_qtr = o.bus_year_qtr)
  when matched 
      and
      (
        not equal_null(n.curr_bus_year_qtr_fg, o.curr_bus_year_qtr_fg)
        or not equal_null(n.bus_year_offset, o.bus_year_offset)
        or not equal_null(n.bus_half_year_offset, o.bus_half_year_offset)
        or not equal_null(n.bus_year_qtr_offset, o.bus_year_qtr_offset)
      )
  then update 
      set n.curr_bus_year_qtr_fg = o.curr_bus_year_qtr_fg,
          n.bus_year_offset = o.bus_year_offset,
          n.bus_half_year_offset = o.bus_half_year_offset,
          n.bus_year_qtr_offset = o.bus_year_qtr_offset,
          n.dwh_updated_tmsp = current_timestamp(),
          n.dwh_load_id = ${LOAD_ID},
          n.dwh_node_cd = 'MANUAL'
;

-- Calendar_1 Month
 merge
  into core_dim.t_dim_calendar_month_1 n
 using(select b.cal_month,
              case when b.cal_month = c.cal_month then true else false end as curr_cal_month_fg,
              dense_rank() over (order by b.cal_year) - c.offset_cal_year as cal_year_offset,
              dense_rank() over (order by b.cal_half_year) - c.offset_cal_half_year as cal_half_year_offset,
              dense_rank() over (order by b.cal_year_qtr) - c.offset_cal_year_qtr as cal_year_qtr_offset,
              dense_rank() over (order by b.bus_year) - c.offset_bus_year as bus_year_offset,
              dense_rank() over (order by b.bus_half_year) - c.offset_bus_half_year as bus_half_year_offset,
              dense_rank() over (order by b.bus_year_qtr) - c.offset_bus_year_qtr as bus_year_qtr_offset,
              dense_rank() over (order by b.cal_month) - c.offset_cal_month as cal_month_offset
         from core_dim.t_dim_calendar_month_1 b
        cross
         join(select cal_month,
                     offset_cal_month,
                     offset_cal_year,
                     offset_bus_year,
                     offset_cal_half_year,
                     offset_bus_half_year,
                     offset_cal_year_qtr,
                     offset_bus_year_qtr
                from(select cal_month,
                            cal_month_begin_dt,
                            cal_month_end_dt,
                            dense_rank() over (order by cal_month) as offset_cal_month,
                            dense_rank() over (order by cal_year) as offset_cal_year,
                            dense_rank() over (order by bus_year) as offset_bus_year,
                            dense_rank() over (order by cal_half_year) as offset_cal_half_year,
                            dense_rank() over (order by bus_half_year) as offset_bus_half_year,
                            dense_rank() over (order by cal_year_qtr) as offset_cal_year_qtr,
                            dense_rank() over (order by bus_year_qtr) as offset_bus_year_qtr
                       from core_dim.t_dim_calendar_month_1
                      where cal_month != -1
                    )
               where current_date between cal_month_begin_dt and cal_month_end_dt
             ) c
        where b.cal_month != -1
      ) o
    on(n.cal_month = o.cal_month)
  when matched 
      and
      (
        not equal_null(n.curr_cal_month_fg, o.curr_cal_month_fg)
        or not equal_null(n.cal_year_offset, o.cal_year_offset)
        or not equal_null(n.cal_half_year_offset, o.cal_half_year_offset)
        or not equal_null(n.cal_year_qtr_offset, o.cal_year_qtr_offset)
        or not equal_null(n.cal_month_offset, o.cal_month_offset)
        or not equal_null(n.bus_year_offset, o.bus_year_offset)
        or not equal_null(n.bus_half_year_offset, o.bus_half_year_offset)
        or not equal_null(n.bus_year_qtr_offset, o.bus_year_qtr_offset)
      )
  then update 
      set n.curr_cal_month_fg = o.curr_cal_month_fg,
          n.cal_year_offset = o.cal_year_offset,
          n.cal_half_year_offset = o.cal_half_year_offset,
          n.cal_year_qtr_offset = o.cal_year_qtr_offset,
          n.cal_month_offset = o.cal_month_offset,
          n.bus_year_offset = o.bus_year_offset,
          n.bus_half_year_offset = o.bus_half_year_offset,
          n.bus_year_qtr_offset = o.bus_year_qtr_offset,
          n.dwh_updated_tmsp = current_timestamp(),
          n.dwh_load_id = ${LOAD_ID},
          n.dwh_node_cd = 'MANUAL'
;

-- Calendar_1 Week
 merge
  into core_dim.t_dim_calendar_week_1 n
 using(select b.cal_week,
              case when b.cal_week = c.cal_week then true else false end as curr_cal_week_fg,
              dense_rank() over (order by b.cal_week) - c.offset_cal_week as cal_week_offset
         from core_dim.t_dim_calendar_week_1 b
        cross
         join(select cal_week,
                     offset_cal_week
                from(select cal_week,
                            cal_week_begin_dt,
                            cal_week_end_dt,
                            dense_rank() over (order by cal_week) as offset_cal_week
                       from core_dim.t_dim_calendar_week_1
                      where cal_week != -1
                    )
               where current_date between cal_week_begin_dt and cal_week_end_dt
             ) c
        where b.cal_week != -1
      ) o
    on(n.cal_week = o.cal_week)
  when matched 
      and
      (
        not equal_null(n.curr_cal_week_fg, o.curr_cal_week_fg)
        or not equal_null(n.cal_week_offset, o.cal_week_offset)
      )
  then update 
      set n.curr_cal_week_fg = o.curr_cal_week_fg,
          n.cal_week_offset = o.cal_week_offset,
          n.dwh_updated_tmsp = current_timestamp(),
          n.dwh_load_id = ${LOAD_ID},
          n.dwh_node_cd = 'MANUAL'
;

-- Calendar_1 Partial Week
 merge
  into core_dim.t_dim_calendar_partial_week_1 n
 using(select b.part_week,
              case when b.part_week = c.part_week then true else false end as curr_part_week_fg,
              dense_rank() over (order by b.cal_year) - c.offset_cal_year as cal_year_offset,
              dense_rank() over (order by b.cal_half_year) - c.offset_cal_half_year as cal_half_year_offset,
              dense_rank() over (order by b.cal_year_qtr) - c.offset_cal_year_qtr as cal_year_qtr_offset,
              dense_rank() over (order by b.bus_year) - c.offset_bus_year as bus_year_offset,
              dense_rank() over (order by b.bus_half_year) - c.offset_bus_half_year as bus_half_year_offset,
              dense_rank() over (order by b.bus_year_qtr) - c.offset_bus_year_qtr as bus_year_qtr_offset,
              dense_rank() over (order by b.cal_month) - c.offset_cal_month as cal_month_offset,
              dense_rank() over (order by b.cal_week) - c.offset_cal_week as cal_week_offset,
              dense_rank() over (order by b.part_week) - c.offset_part_week as part_week_offset
         from core_dim.t_dim_calendar_partial_week_1 b
        cross
         join(select part_week,
                     offset_cal_month,
                     offset_cal_year,
                     offset_bus_year,
                     offset_cal_half_year,
                     offset_bus_half_year,
                     offset_cal_year_qtr,
                     offset_bus_year_qtr,
                     offset_cal_week,
                     offset_part_week
                from(select part_week,
                            part_week_begin_dt,
                            part_week_end_dt,
                            dense_rank() over (order by cal_month) as offset_cal_month,
                            dense_rank() over (order by cal_year) as offset_cal_year,
                            dense_rank() over (order by bus_year) as offset_bus_year,
                            dense_rank() over (order by cal_half_year) as offset_cal_half_year,
                            dense_rank() over (order by bus_half_year) as offset_bus_half_year,
                            dense_rank() over (order by cal_year_qtr) as offset_cal_year_qtr,
                            dense_rank() over (order by bus_year_qtr) as offset_bus_year_qtr,
                            dense_rank() over (order by cal_week) as offset_cal_week,
                            dense_rank() over (order by part_week) as offset_part_week
                       from core_dim.t_dim_calendar_partial_week_1
                      where part_week != -1
                    )
               where current_date between part_week_begin_dt and part_week_end_dt
             ) c
        where b.part_week != -1
      ) o
    on(n.part_week = o.part_week)
  when matched 
      and
      (
        not equal_null(n.curr_part_week_fg, o.curr_part_week_fg)
        or not equal_null(n.cal_year_offset, o.cal_year_offset)
        or not equal_null(n.cal_half_year_offset, o.cal_half_year_offset)
        or not equal_null(n.cal_year_qtr_offset, o.cal_year_qtr_offset)
        or not equal_null(n.cal_month_offset, o.cal_month_offset)
        or not equal_null(n.bus_year_offset, o.bus_year_offset)
        or not equal_null(n.bus_half_year_offset, o.bus_half_year_offset)
        or not equal_null(n.bus_year_qtr_offset, o.bus_year_qtr_offset)
        or not equal_null(n.cal_week_offset, o.cal_week_offset)
        or not equal_null(n.part_week_offset, o.part_week_offset)
      )
  then update 
      set n.curr_part_week_fg = o.curr_part_week_fg,
          n.cal_year_offset = o.cal_year_offset,
          n.cal_half_year_offset = o.cal_half_year_offset,
          n.cal_year_qtr_offset = o.cal_year_qtr_offset,
          n.cal_month_offset = o.cal_month_offset,
          n.bus_year_offset = o.bus_year_offset,
          n.bus_half_year_offset = o.bus_half_year_offset,
          n.bus_year_qtr_offset = o.bus_year_qtr_offset,
          n.cal_week_offset = o.cal_week_offset,
          n.part_week_offset = o.part_week_offset,
          n.dwh_updated_tmsp = current_timestamp(),
          n.dwh_load_id = ${LOAD_ID},
          n.dwh_node_cd = 'MANUAL'
;

-- Calendar_1 Date
 merge
  into core_dim.t_dim_calendar_date_1 n
 using(select b.cal_dt,
              case when b.cal_dt = c.cal_dt then true else false end as curr_cal_dt_fg,
              dense_rank() over (order by b.cal_year) - c.offset_cal_year as cal_year_offset,
              dense_rank() over (order by b.cal_half_year) - c.offset_cal_half_year as cal_half_year_offset,
              dense_rank() over (order by b.cal_year_qtr) - c.offset_cal_year_qtr as cal_year_qtr_offset,
              dense_rank() over (order by b.bus_year) - c.offset_bus_year as bus_year_offset,
              dense_rank() over (order by b.bus_half_year) - c.offset_bus_half_year as bus_half_year_offset,
              dense_rank() over (order by b.bus_year_qtr) - c.offset_bus_year_qtr as bus_year_qtr_offset,
              dense_rank() over (order by b.cal_month) - c.offset_cal_month as cal_month_offset,
              dense_rank() over (order by b.cal_week) - c.offset_cal_week as cal_week_offset,
              dense_rank() over (order by b.part_week) - c.offset_part_week as part_week_offset,
              dense_rank() over (order by b.cal_dt) - c.offset_cal_dt as cal_dt_offset
         from core_dim.t_dim_calendar_date_1 b
        cross
         join(select cal_dt,
                     offset_cal_month,
                     offset_cal_year,
                     offset_bus_year,
                     offset_cal_half_year,
                     offset_bus_half_year,
                     offset_cal_year_qtr,
                     offset_bus_year_qtr,
                     offset_cal_week,
                     offset_part_week,
                     offset_cal_dt
                from(select cal_dt,
                            dense_rank() over (order by cal_month) as offset_cal_month,
                            dense_rank() over (order by cal_year) as offset_cal_year,
                            dense_rank() over (order by bus_year) as offset_bus_year,
                            dense_rank() over (order by cal_half_year) as offset_cal_half_year,
                            dense_rank() over (order by bus_half_year) as offset_bus_half_year,
                            dense_rank() over (order by cal_year_qtr) as offset_cal_year_qtr,
                            dense_rank() over (order by bus_year_qtr) as offset_bus_year_qtr,
                            dense_rank() over (order by cal_week) as offset_cal_week,
                            dense_rank() over (order by part_week) as offset_part_week,
                            dense_rank() over (order by cal_dt) as offset_cal_dt
                       from core_dim.t_dim_calendar_date_1
                      where cal_dt != '0001-01-01'
                    )
               where current_date = cal_dt
             ) c
        where b.cal_dt != '0001-01-01'
      ) o
    on(n.cal_dt = o.cal_dt)
  when matched 
      and
      (
        not equal_null(n.curr_cal_dt_fg, o.curr_cal_dt_fg)
        or not equal_null(n.cal_year_offset, o.cal_year_offset)
        or not equal_null(n.cal_half_year_offset, o.cal_half_year_offset)
        or not equal_null(n.cal_year_qtr_offset, o.cal_year_qtr_offset)
        or not equal_null(n.cal_month_offset, o.cal_month_offset)
        or not equal_null(n.bus_year_offset, o.bus_year_offset)
        or not equal_null(n.bus_half_year_offset, o.bus_half_year_offset)
        or not equal_null(n.bus_year_qtr_offset, o.bus_year_qtr_offset)
        or not equal_null(n.cal_week_offset, o.cal_week_offset)
        or not equal_null(n.part_week_offset, o.part_week_offset)
        or not equal_null(n.cal_dt_offset, o.cal_dt_offset)
      )
  then update 
      set n.curr_cal_dt_fg = o.curr_cal_dt_fg,
          n.cal_year_offset = o.cal_year_offset,
          n.cal_half_year_offset = o.cal_half_year_offset,
          n.cal_year_qtr_offset = o.cal_year_qtr_offset,
          n.cal_month_offset = o.cal_month_offset,
          n.bus_year_offset = o.bus_year_offset,
          n.bus_half_year_offset = o.bus_half_year_offset,
          n.bus_year_qtr_offset = o.bus_year_qtr_offset,
          n.cal_week_offset = o.cal_week_offset,
          n.part_week_offset = o.part_week_offset,
          n.cal_dt_offset = o.cal_dt_offset,
          n.dwh_updated_tmsp = current_timestamp(),
          n.dwh_load_id = ${LOAD_ID},
          n.dwh_node_cd = 'MANUAL'
;
