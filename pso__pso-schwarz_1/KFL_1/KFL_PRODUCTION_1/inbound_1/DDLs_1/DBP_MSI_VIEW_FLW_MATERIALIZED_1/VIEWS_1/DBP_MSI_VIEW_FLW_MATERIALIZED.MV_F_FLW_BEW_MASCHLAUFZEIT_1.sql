create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_F_FLW_BEW_MASCHLAUFZEIT_1(
	WERK_ID,
	FLW_ARBEITSPLATZ_ID,
	PRODUKTIONSZYKLUSID,
	IN_ART_ID,
	PRODUKTIONSTAG,
	MANDANT_ID,
	ZEITSTEMPEL_ERFASSSUNG,
	DAT_HALTBARKEIT,
	AUFTRAG_ID,
	MAT_FLAG,
	PREIS_FLAG,
	MHD_FLAG,
	AUFTRAG_FLAG,
	ANZAHL_KOLLI,
	MENGE_BME,
	NETTOGEW,
	BETRAG_BEW,
	DAUER,
	UNTERBERECHUNGSZEIT,
	UNTERBRECHUNGEN,
	MAT_WECHSELTIME,
	PREIS_WECHSELTIME,
	MHD_WECHSELTIME,
	AUFTRAG_WECHSELTIME,
	START_TS,
	END_TS
) as 
with basic as (Select werk_id,dat_erfasst, zeit_erfasst, flw_arbeitsplatz_id,
auftrag_id,
loesch_fg,
dat_haltbarkeit,
in_art_id,
mandant_id,
betrag_bew, --auszeichnungspreis
cast ( dat_erfasst || ' ' || zeit_Erfasst AS TIMESTAMP(3)  ) as new_tss,
case when (zeit_erfasst < '05:00:00') then dat_erfasst -1 else Dat_Erfasst end as Produktionstag,

menge_bme, 
nettogew

 from DBP_MSI_VIEW_FLW_MATERIALIZED.MV_F_FLW_BEW_1  
	
where flw_arbeitsplatz_id is not null and 
 flw_beleg_typ_id = 'SE'
-- Einschrankung auf die letzten beiden GJ und das aktuelle GJ              
and dat_erfasst >= to_Date('01.03.' ||cast( year(CURRENT_DATE)-2 as varchar), 'dd.mm.yyyy')
and (werk_id = 5 or (werk_id<> 5 
and loesch_fg = 1))
)
, wechsel_tab as (
Select basic.*,
--- Zeit_1 davor 
lag(new_tss) over (Partition by werk_id,Produktionstag, flw_arbeitsplatz_id order by werk_id, dat_erfasst, zeit_erfasst,flw_arbeitsplatz_id) as  time_Davor,
-- Artikelwechsel 
lag(in_art_id) over (Partition by werk_id,Produktionstag, flw_arbeitsplatz_id order by werk_id, dat_erfasst, zeit_erfasst,flw_arbeitsplatz_id) as mat_vorher,
--lag(new_tss) over (Partition by werk_id,Produktionstag, flw_arbeitsplatz_id order by werk_id desc, dat_erfasst desc, zeit_erfasst desc,flw_arbeitsplatz_id desc) as  last_time,
-- Preiswechsel 
lag(betrag_bew) over (Partition by werk_id,Produktionstag, flw_arbeitsplatz_id,in_art_id order by werk_id, dat_erfasst, zeit_erfasst,flw_arbeitsplatz_id) as preis_vorher,
-- MHD wechsel 
lag(dat_haltbarkeit) over (Partition by werk_id,Produktionstag, flw_arbeitsplatz_id,in_art_id,betrag_bew order by werk_id, dat_erfasst, zeit_erfasst,flw_arbeitsplatz_id) as MHD_vorher,
-- Auftragswechsel 
lag(auftrag_id) over (Partition by werk_id,Produktionstag, flw_arbeitsplatz_id,in_art_id,betrag_bew, dat_haltbarkeit order by werk_id, dat_erfasst, zeit_erfasst,flw_arbeitsplatz_id) as auftrag_vorher

from basic),
--order by werk_id, dat_erfasst, zeit_erfasst,flw_arbeitsplatz_id) 
tab2 as (
select    wechsel_tab.*,
--cast(((new_tss - time_davor) second(4)) as number(38,2)) as Zeitdiff_sec,
/*(CAST((CAST(new_tss AS DATE )- CAST(time_davor AS DATE )) AS DECIMAL(18,6)) * 86400)
      + ((EXTRACT(  HOUR FROM new_tss) - EXTRACT(  HOUR FROM time_davor)) * 3600)
      + ((EXTRACT(MINUTE FROM new_tss) - EXTRACT(MINUTE FROM time_davor)) * 60)
      +  (EXTRACT(SECOND FROM new_tss) - EXTRACT(SECOND FROM time_davor)) as Zeitdiff_sec,*/
timestampdiff('second',time_davor,new_tss) as Zeitdiff_sec,

---- Artikelwechsel 
case when mat_vorher <> in_art_id or mat_vorher is null then 1 else 0 end as mat_flag, 
-- Preiswechsel (muss preis sich unterscheiden ABER kein Wechsel statt gefunden haben)
case when betrag_bew <> preis_vorher and mat_flag = 0 then 1 else 0 end as preis_flag, 
-- MHD wechsel 
case when dat_haltbarkeit <> MHD_vorher and mat_flag = 0  and  preis_flag = 0  then 1 else 0 end as mhd_flag, 
-- Auftragswechsel 
case when auftrag_id <> auftrag_vorher and mat_flag = 0  and  preis_flag = 0 and  mhd_flag = 0  then 1 else 0 end as auftrag_flag,
  
sum(mat_flag) over (Partition by werk_id, Produktionstag ,flw_arbeitsplatz_id order by werk_id, dat_erfasst, zeit_erfasst  ROWS UNBOUNDED PRECEDING) as anz_wechsel
from wechsel_tab
 ) 
, tab03 as( 
Select tab2.*,
max(new_tss) over (partition by anz_wechsel) as end_time,
---
trim(flw_arbeitsplatz_id) || '_' || to_char(anz_wechsel, 'fm000') as ProduktionszyklusID,

-- timegaps 
-- Artikel_1
case when mat_flag = 1 and  Zeitdiff_sec <= 600 then Zeitdiff_sec
when mat_flag = 1 and Zeitdiff_sec > 600 then 600.0
else 0.0  end as mat_wechseltime ,
-- Preis
case when preis_flag = 1 and  Zeitdiff_sec <= 600 then Zeitdiff_sec 
when preis_flag = 1 and Zeitdiff_sec > 600 then 600.0
else 0.0  end as preis_wechseltime, 
-- MHD 
case when mhd_flag = 1 and  Zeitdiff_sec <= 600 then Zeitdiff_sec 
when mhd_flag = 1 and Zeitdiff_sec > 600 then 600.0
else 0.0  end as MHD_wechseltime, 
-- Auftrag
case when auftrag_flag = 1 and  Zeitdiff_sec <= 600 then Zeitdiff_sec 
when auftrag_flag = 1 and Zeitdiff_sec > 600 then 600.0
else 0.0  end as auftrag_wechseltime,

-- Unterbrechung 
-- wenn kein Wechsel vorliegt, dann liegt eine_1 Unterbrechung vor bei einer Dauer ueber 3 min
-- wenn ein Wechsel vorliegt, dann werden 10 min dem Wechsel zu geschrieben und alles darueberhinaus der Unterbrechung
case when (Zeitdiff_sec > 180 and mat_flag = 0 and preis_flag = 0 and mhd_flag= 0 and auftrag_flag = 0)
or (Zeitdiff_sec > 600 and ( mat_flag = 1 or preis_flag = 1 or mhd_flag= 1 or auftrag_flag = 1))
 then 1 else 0 end as Unterbrechungen,

-- Unterbrechungszeit. 
Case when Unterbrechungen = 1 and ( mat_flag = 1 or preis_flag = 1 or mhd_flag= 1 or auftrag_flag = 1) 
      then Zeitdiff_sec - mat_wechseltime - preis_wechseltime - MHD_wechseltime - auftrag_wechseltime 
when Unterbrechungen = 1 and   mat_flag = 0 and preis_flag = 0 and mhd_flag= 0 and auftrag_flag = 0 
      then Zeitdiff_sec
else 0 
end as unterberechungszeit
from tab2)

Select werk_id,
flw_arbeitsplatz_id, 
ProduktionszyklusID,
in_art_id, 
Produktionstag, 
mandant_id,
new_tss as Zeitstempel_erfasssung,
dat_haltbarkeit,
auftrag_id,
/*mat_flag,
preis_flag,
mhd_flag,
new_tss,
anz_wechsel*/

sum(mat_flag) as mat_flag, 
SUM(preis_flag) as preis_flag, 
SUM(mhd_flag) as mhd_flag, 
SUM(auftrag_flag) as auftrag_flag,
Count(in_art_id) as Anzahl_Kolli, 
sum(menge_bme) as menge_bme, 
sum(nettogew) As nettogew, 
sum(betrag_bew) As betrag_bew,
sum(Zeitdiff_sec) as dauer,
--unterbrechungen 
sum(unterberechungszeit) as unterberechungszeit, 
sum( Unterbrechungen) as unterbrechungen, 
--Wechselzeit 
sum(mat_wechseltime) As mat_wechseltime,
sum(preis_wechseltime) as preis_wechseltime,
sum(MHD_wechseltime) as MHD_wechseltime,
sum(auftrag_wechseltime) as auftrag_wechseltime,

--cast(min(new_tss) as TIME) as Start_ts, 
case when time_davor is null then new_tss else time_davor end as Start_ts,
cast(max(new_tss) as TIME) As End_ts

from Tab03
--where mat_vorher is null or mat_vorher <> in_art_id or betrag_bew <> preis_vorher or dat_haltbarkeit <> MHD_vorher or auftrag_id <> auftrag_vorher

group by werk_id,
flw_arbeitsplatz_id, 
ProduktionszyklusID,
in_art_id, 
Produktionstag, mandant_id, new_tss,
dat_haltbarkeit,
auftrag_id,
time_davor
--order by werk_id,Produktionstag,ProduktionszyklusID;