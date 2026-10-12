insert into dbp_data.l_nachhaltigkeitslogo_1 (nachhaltigkeitslogo_id,nachhaltigkeitslogo_bez, td_insert, td_update)
select -1,CONCAT(lower(nachhaltigkeitslogo_bez),'_fg') as nachhaltigkeitslogo_bez_, CURRENT_TIMESTAMP,CURRENT_TIMESTAMP
FROM 
(
select substr(nachhaltigkeitslogo_bez,1,3) as nachhaltigkeitslogo_bez from dbp_etl.l_nachhaltigkeitslogo_1
union
select substr(nachhaltigkeitslogo_bez,4,3) as nachhaltigkeitslogo_bez from dbp_etl.l_nachhaltigkeitslogo_1 where length(nachhaltigkeitslogo_bez)>3 
union
select substr(nachhaltigkeitslogo_bez,7,3) as nachhaltigkeitslogo_bez from dbp_etl.l_nachhaltigkeitslogo_1 where length(nachhaltigkeitslogo_bez)>6 
union
select substr(nachhaltigkeitslogo_bez,10,3) as nachhaltigkeitslogo_bez from dbp_etl.l_nachhaltigkeitslogo_1 where length(nachhaltigkeitslogo_bez)>9 
union
select substr(nachhaltigkeitslogo_bez,13,3) as nachhaltigkeitslogo_bez from dbp_etl.l_nachhaltigkeitslogo_1 where length(nachhaltigkeitslogo_bez)>12 
union
select substr(nachhaltigkeitslogo_bez,16,3) as nachhaltigkeitslogo_bez from dbp_etl.l_nachhaltigkeitslogo_1 where length(nachhaltigkeitslogo_bez)>15
union
select substr(nachhaltigkeitslogo_bez,19,3) as nachhaltigkeitslogo_bez from dbp_etl.l_nachhaltigkeitslogo_1 where length(nachhaltigkeitslogo_bez)>18
union
select substr(nachhaltigkeitslogo_bez,122,3) as nachhaltigkeitslogo_bez from dbp_etl.l_nachhaltigkeitslogo_1 where length(nachhaltigkeitslogo_bez)>21 
GROUP BY nachhaltigkeitslogo_bez
)
WHERE nachhaltigkeitslogo_bez_ not in (SELECT nachhaltigkeitslogo_bez FROM dbp_data.l_nachhaltigkeitslogo_1)
;
