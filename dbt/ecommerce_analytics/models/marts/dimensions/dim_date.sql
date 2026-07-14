select

    cast(strftime(calendar_date, '%Y%m%d') as integer) as date_sk,

    calendar_date,

    year(calendar_date) as year,

    quarter(calendar_date) as quarter,

    month(calendar_date) as month,

    monthname(calendar_date) as month_name,

    week(calendar_date) as week,

    day(calendar_date) as day,

    dayname(calendar_date) as day_name,

    dayofweek(calendar_date) as day_of_week,

    case
        when dayofweek(calendar_date) in (0, 6)
            then true
        else false
    end as is_weekend

from generate_series(

    date '2016-09-04',
    date '2020-04-09',
    interval 1 day

) t(calendar_date)