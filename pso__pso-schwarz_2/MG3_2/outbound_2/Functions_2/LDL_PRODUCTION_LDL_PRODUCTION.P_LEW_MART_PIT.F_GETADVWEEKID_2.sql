CREATE OR REPLACE FUNCTION `ldl_production_p_lew_mart_pit.f_getadvweekid`(
  pStartDate DATE,
  pAdvWeekStartDayId INT64
)
RETURNS INT64
AS (
  CASE
    -- Check Input
    WHEN pAdvWeekStartDayId < 0
         OR pAdvWeekStartDayId > 7
         OR pStartDate IS NULL
      THEN 888853

    -- Case Adv.Week starts on Sunday --> than the next KalenderWeek (based on ISO)
    WHEN pAdvWeekStartDayId = 7
      THEN (
        EXTRACT(ISOYEAR FROM DATE_ADD(pStartDate, INTERVAL 1 DAY)) * 100 +
        EXTRACT(ISOWEEK FROM DATE_ADD(pStartDate, INTERVAL 1 DAY))
      )

    -- Case Adv.Week starts on Monday --> then same as Kalender Week (based on ISO)
    WHEN pAdvWeekStartDayId = 1
      THEN (
        EXTRACT(ISOYEAR FROM pStartDate) * 100 +
        EXTRACT(ISOWEEK FROM pStartDate)
      )

    -- Tue,Wed,Thu,Fri,Sat
    WHEN EXTRACT(DAYOFWEEK FROM pStartDate) >= pAdvWeekStartDayId
         AND pAdvWeekStartDayId < 7
      THEN (
        EXTRACT(ISOYEAR FROM pStartDate) * 100 +
        EXTRACT(ISOWEEK FROM pStartDate)
      )

    ELSE (
      EXTRACT(ISOYEAR FROM DATE_ADD(pStartDate, INTERVAL -7 DAY)) * 100 +
      EXTRACT(ISOWEEK FROM DATE_ADD(pStartDate, INTERVAL -7 DAY))
    )
  END
);