SELECT COUNT(*) FROM (
SELECT    *
FROM      akt_zeitfenster_$_2{TRANSIENT_TABLE_SUFFIX}
WHERE     zeitfenster_id = 3
);


