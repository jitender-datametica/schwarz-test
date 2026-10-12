create or replace view DBP_ETL_PROCESS.V_AIS_CLEAN_ROW_CANCELLATION(
	MANDANT_ID,
	WUP_ID,
	BON_DAT,
	BON_ID,
	KL_ART_ID,
	UMSATZ_BRUTTO,
	BON_ZEILE,
	TALON_ID
) as (
select a.mandant_id,
       a.wup_id,
       a.bon_dat,
       a.bon_id,
       a.kl_art_id,
       a.umsatz_brutto,
       a.bon_zeile,
       a.talon_id
from dbp_etl_process.artbew_zeilen_stornos a
join (select mandant_id,
             wup_id,
             bon_dat,
             bon_id,
             kl_art_id,
             ean_kasse,
             umsatz_brutto,
             count(*) as anzahl
      from dbp_etl_process.artbew_zeilen_stornos
      where menge < 0 and
            talon_id <> 0
	  group by 1,2,3,4,5,6,7) b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id and
     a.bon_dat = b.bon_dat and
     a.bon_id = b.bon_id and
     a.kl_art_id = b.kl_art_id and
     a.ean_kasse = b.ean_kasse and
    (-1)*a.umsatz_brutto = case
	                           when b.anzahl >= 1
                             then b.umsatz_brutto
							               else null
						               end
qualify row_number() over (partition by a.mandant_id, a.wup_id, a.bon_dat,a.bon_id, a.kl_art_id, a.umsatz_brutto order by a.bon_zeile desc) = 1
union
select a.mandant_id,
       a.wup_id,
       a.bon_dat,
       a.bon_id,
       a.kl_art_id,
       a.umsatz_brutto,
       a.bon_zeile,
       a.talon_id
from dbp_etl_process.artbew_zeilen_stornos a
join (select mandant_id,
             wup_id,
             bon_dat,
             bon_id,
             kl_art_id,
             ean_kasse,
             umsatz_brutto,
             count(*) as anzahl
      from dbp_etl_process.artbew_zeilen_stornos
      where menge < 0 and
            talon_id <> 0
	  group by 1,2,3,4,5,6,7) b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id and
     a.bon_dat = b.bon_dat and
     a.bon_id = b.bon_id and
     a.kl_art_id = b.kl_art_id and
     a.ean_kasse = b.ean_kasse and
    (-1)*a.umsatz_brutto = case
	                           when b.anzahl >= 2
                             then b.umsatz_brutto
							               else null
						               end
qualify row_number() over (partition by a.mandant_id, a.wup_id, a.bon_dat,a.bon_id, a.kl_art_id, a.umsatz_brutto order by a.bon_zeile desc) = 2
union
select a.mandant_id,
       a.wup_id,
       a.bon_dat,
       a.bon_id,
       a.kl_art_id,
       a.umsatz_brutto,
       a.bon_zeile,
       a.talon_id
from dbp_etl_process.artbew_zeilen_stornos a
join (select mandant_id,
             wup_id,
             bon_dat,
             bon_id,
             kl_art_id,
             ean_kasse,
             umsatz_brutto,
             count(*) as anzahl
      from dbp_etl_process.artbew_zeilen_stornos
      where menge < 0 and
            talon_id <> 0
	  group by 1,2,3,4,5,6,7) b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id and
     a.bon_dat = b.bon_dat and
     a.bon_id = b.bon_id and
     a.kl_art_id = b.kl_art_id and
     a.ean_kasse = b.ean_kasse and
    (-1)*a.umsatz_brutto = case
	                           when b.anzahl >= 3
                             then b.umsatz_brutto
							               else null
						               end
qualify row_number() over (partition by a.mandant_id, a.wup_id, a.bon_dat,a.bon_id, a.kl_art_id, a.umsatz_brutto order by a.bon_zeile desc) =3
union
select a.mandant_id,
       a.wup_id,
       a.bon_dat,
       a.bon_id,
       a.kl_art_id,
       a.umsatz_brutto,
       a.bon_zeile,
       a.talon_id
from dbp_etl_process.artbew_zeilen_stornos a
join (select mandant_id,
             wup_id,
             bon_dat,
             bon_id,
             kl_art_id,
             ean_kasse,
             umsatz_brutto,
             count(*) as anzahl
      from dbp_etl_process.artbew_zeilen_stornos
      where menge < 0 and
            talon_id <> 0
	  group by 1,2,3,4,5,6,7) b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id and
     a.bon_dat = b.bon_dat and
     a.bon_id = b.bon_id and
     a.kl_art_id = b.kl_art_id and
     a.ean_kasse = b.ean_kasse and
    (-1)*a.umsatz_brutto = case
	                           when b.anzahl >= 4
                             then b.umsatz_brutto
							               else null
						               end
qualify row_number() over (partition by a.mandant_id, a.wup_id, a.bon_dat,a.bon_id, a.kl_art_id, a.umsatz_brutto order by a.bon_zeile desc) = 4
union
select a.mandant_id,
       a.wup_id,
       a.bon_dat,
       a.bon_id,
       a.kl_art_id,
       a.umsatz_brutto,
       a.bon_zeile,
       a.talon_id
from dbp_etl_process.artbew_zeilen_stornos a
join (select mandant_id,
             wup_id,
             bon_dat,
             bon_id,
             kl_art_id,
             ean_kasse,
             umsatz_brutto,
             count(*) as anzahl
      from dbp_etl_process.artbew_zeilen_stornos
      where menge < 0 and
            talon_id <> 0
	  group by 1,2,3,4,5,6,7) b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id and
     a.bon_dat = b.bon_dat and
     a.bon_id = b.bon_id and
     a.kl_art_id = b.kl_art_id and
     a.ean_kasse = b.ean_kasse and
    (-1)*a.umsatz_brutto = case
	                           when b.anzahl >= 5
                             then b.umsatz_brutto
							               else null
						               end
qualify row_number() over (partition by a.mandant_id, a.wup_id, a.bon_dat,a.bon_id, a.kl_art_id, a.umsatz_brutto order by a.bon_zeile desc) = 5
union
select a.mandant_id,
       a.wup_id,
       a.bon_dat,
       a.bon_id,
       a.kl_art_id,
       a.umsatz_brutto,
       a.bon_zeile,
       a.talon_id
from dbp_etl_process.artbew_zeilen_stornos a
join (select mandant_id,
             wup_id,
             bon_dat,
             bon_id,
             kl_art_id,
             ean_kasse,
             umsatz_brutto,
             count(*) as anzahl
      from dbp_etl_process.artbew_zeilen_stornos
      where menge < 0 and
            talon_id <> 0
	  group by 1,2,3,4,5,6,7) b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id and
     a.bon_dat = b.bon_dat and
     a.bon_id = b.bon_id and
     a.kl_art_id = b.kl_art_id and
     a.ean_kasse = b.ean_kasse and
    (-1)*a.umsatz_brutto = case
	                           when b.anzahl >= 6
                             then b.umsatz_brutto
							               else null
						               end
qualify row_number() over (partition by a.mandant_id, a.wup_id, a.bon_dat,a.bon_id, a.kl_art_id, a.umsatz_brutto order by a.bon_zeile desc) = 6
union
select a.mandant_id,
       a.wup_id,
       a.bon_dat,
       a.bon_id,
       a.kl_art_id,
       a.umsatz_brutto,
       a.bon_zeile,
       a.talon_id
from dbp_etl_process.artbew_zeilen_stornos a
join (select mandant_id,
             wup_id,
             bon_dat,
             bon_id,
             kl_art_id,
             ean_kasse,
             umsatz_brutto,
             count(*) as anzahl
      from dbp_etl_process.artbew_zeilen_stornos
      where menge < 0 and
            talon_id <> 0
	  group by 1,2,3,4,5,6,7) b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id and
     a.bon_dat = b.bon_dat and
     a.bon_id = b.bon_id and
     a.kl_art_id = b.kl_art_id and
     a.ean_kasse = b.ean_kasse and
    (-1)*a.umsatz_brutto = case
	                           when b.anzahl >= 7
                             then b.umsatz_brutto
							               else null
						               end
qualify row_number() over (partition by a.mandant_id, a.wup_id, a.bon_dat,a.bon_id, a.kl_art_id, a.umsatz_brutto order by a.bon_zeile desc) = 7
union
select a.mandant_id,
       a.wup_id,
       a.bon_dat,
       a.bon_id,
       a.kl_art_id,
       a.umsatz_brutto,
       a.bon_zeile,
       a.talon_id
from dbp_etl_process.artbew_zeilen_stornos a
join (select mandant_id,
             wup_id,
             bon_dat,
             bon_id,
             kl_art_id,
             ean_kasse,
             umsatz_brutto,
             count(*) as anzahl
      from dbp_etl_process.artbew_zeilen_stornos
      where menge < 0 and
            talon_id <> 0
	  group by 1,2,3,4,5,6,7) b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id and
     a.bon_dat = b.bon_dat and
     a.bon_id = b.bon_id and
     a.kl_art_id = b.kl_art_id and
     a.ean_kasse = b.ean_kasse and
    (-1)*a.umsatz_brutto = case
	                           when b.anzahl >= 8
                             then b.umsatz_brutto
							               else null
						               end
qualify row_number() over (partition by a.mandant_id, a.wup_id, a.bon_dat,a.bon_id, a.kl_art_id, a.umsatz_brutto order by a.bon_zeile desc) = 8
union
select a.mandant_id,
       a.wup_id,
       a.bon_dat,
       a.bon_id,
       a.kl_art_id,
       a.umsatz_brutto,
       a.bon_zeile,
       a.talon_id
from dbp_etl_process.artbew_zeilen_stornos a
join (select mandant_id,
             wup_id,
             bon_dat,
             bon_id,
             kl_art_id,
             ean_kasse,
             umsatz_brutto,
			       count(*) as anzahl
      from dbp_etl_process.artbew_zeilen_stornos
      where menge < 0 and
            talon_id <> 0
	  group by 1,2,3,4,5,6,7) b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id and
     a.bon_dat = b.bon_dat and
     a.bon_id = b.bon_id and
     a.kl_art_id = b.kl_art_id and
     a.ean_kasse = b.ean_kasse and
    (-1)*a.umsatz_brutto = case
	                           when b.anzahl >= 9
                             then b.umsatz_brutto
							               else null
						               end
qualify row_number() over (partition by a.mandant_id, a.wup_id, a.bon_dat,a.bon_id, a.kl_art_id, a.umsatz_brutto order by a.bon_zeile desc) = 9
union
select a.mandant_id,
       a.wup_id,
       a.bon_dat,
       a.bon_id,
       a.kl_art_id,
       a.umsatz_brutto,
       a.bon_zeile,
       a.talon_id
from dbp_etl_process.artbew_zeilen_stornos a
join (select mandant_id,
             wup_id,
             bon_dat,
             bon_id,
             kl_art_id,
             ean_kasse,
             umsatz_brutto,
             count(*) as anzahl
      from dbp_etl_process.artbew_zeilen_stornos
      where menge < 0 and
            talon_id <> 0
	  group by 1,2,3,4,5,6,7) b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id and
     a.bon_dat = b.bon_dat and
     a.bon_id = b.bon_id and
     a.kl_art_id = b.kl_art_id and
     a.ean_kasse = b.ean_kasse and
    (-1)*a.umsatz_brutto = case
	                           when b.anzahl >= 10
                             then b.umsatz_brutto
							               else null
						               end
qualify row_number() over (partition by a.mandant_id, a.wup_id, a.bon_dat,a.bon_id, a.kl_art_id, a.umsatz_brutto order by a.bon_zeile desc) = 10
union
select a.mandant_id,
       a.wup_id,
       a.bon_dat,
       a.bon_id,
       a.kl_art_id,
       a.umsatz_brutto,
       a.bon_zeile,
       a.talon_id
from dbp_etl_process.artbew_zeilen_stornos a
join (select mandant_id,
             wup_id,
             bon_dat,
             bon_id,
             kl_art_id,
             ean_kasse,
             umsatz_brutto,
			       count(*) as anzahl
      from dbp_etl_process.artbew_zeilen_stornos
      where menge < 0 and
            talon_id <> 0
	  group by 1,2,3,4,5,6,7) b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id and
     a.bon_dat = b.bon_dat and
     a.bon_id = b.bon_id and
     a.kl_art_id = b.kl_art_id and
     a.ean_kasse = b.ean_kasse and
    (-1)*a.umsatz_brutto = case
	                           when b.anzahl >= 11
                             then b.umsatz_brutto
							               else null
						               end
qualify row_number() over (partition by a.mandant_id, a.wup_id, a.bon_dat,a.bon_id, a.kl_art_id, a.umsatz_brutto order by a.bon_zeile desc) = 11
union
select a.mandant_id,
       a.wup_id,
       a.bon_dat,
       a.bon_id,
       a.kl_art_id,
       a.umsatz_brutto,
       a.bon_zeile,
       a.talon_id
from dbp_etl_process.artbew_zeilen_stornos a
join (select mandant_id,
             wup_id,
             bon_dat,
             bon_id,
             kl_art_id,
             ean_kasse,
             umsatz_brutto,
			       count(*) as anzahl
      from dbp_etl_process.artbew_zeilen_stornos
      where menge < 0 and
            talon_id <> 0
	  group by 1,2,3,4,5,6,7) b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id and
     a.bon_dat = b.bon_dat and
     a.bon_id = b.bon_id and
     a.kl_art_id = b.kl_art_id and
     a.ean_kasse = b.ean_kasse and
    (-1)*a.umsatz_brutto = case
	                           when b.anzahl >= 12
                             then b.umsatz_brutto
							               else null
						               end
qualify row_number() over (partition by a.mandant_id, a.wup_id, a.bon_dat,a.bon_id, a.kl_art_id, a.umsatz_brutto order by a.bon_zeile desc) = 12
union
select a.mandant_id,
       a.wup_id,
       a.bon_dat,
       a.bon_id,
       a.kl_art_id,
       a.umsatz_brutto,
       a.bon_zeile,
       a.talon_id
from dbp_etl_process.artbew_zeilen_stornos a
join (select mandant_id,
             wup_id,
             bon_dat,
             bon_id,
             kl_art_id,
             ean_kasse,
             umsatz_brutto,
			       count(*) as anzahl
      from dbp_etl_process.artbew_zeilen_stornos
      where menge < 0 and
            talon_id <> 0
	  group by 1,2,3,4,5,6,7) b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id and
     a.bon_dat = b.bon_dat and
     a.bon_id = b.bon_id and
     a.kl_art_id = b.kl_art_id and
     a.ean_kasse = b.ean_kasse and
    (-1)*a.umsatz_brutto = case
	                           when b.anzahl >= 13
                             then b.umsatz_brutto
							               else null
						               end
qualify row_number() over (partition by a.mandant_id, a.wup_id, a.bon_dat,a.bon_id, a.kl_art_id, a.umsatz_brutto order by a.bon_zeile desc) = 13
union
select a.mandant_id,
       a.wup_id,
       a.bon_dat,
       a.bon_id,
       a.kl_art_id,
       a.umsatz_brutto,
       a.bon_zeile,
       a.talon_id
from dbp_etl_process.artbew_zeilen_stornos a
join (select mandant_id,
             wup_id,
             bon_dat,
             bon_id,
             kl_art_id,
             ean_kasse,
             umsatz_brutto,
			       count(*) as anzahl
      from dbp_etl_process.artbew_zeilen_stornos
      where menge < 0 and
            talon_id <> 0
	  group by 1,2,3,4,5,6,7) b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id and
     a.bon_dat = b.bon_dat and
     a.bon_id = b.bon_id and
     a.kl_art_id = b.kl_art_id and
     a.ean_kasse = b.ean_kasse and
    (-1)*a.umsatz_brutto = case
	                           when b.anzahl >= 14
                             then b.umsatz_brutto
							               else null
						               end
qualify row_number() over (partition by a.mandant_id, a.wup_id, a.bon_dat,a.bon_id, a.kl_art_id, a.umsatz_brutto order by a.bon_zeile desc) = 14
union
select a.mandant_id,
       a.wup_id,
       a.bon_dat,
       a.bon_id,
       a.kl_art_id,
       a.umsatz_brutto,
       a.bon_zeile,
       a.talon_id
from dbp_etl_process.artbew_zeilen_stornos a
join (select mandant_id,
             wup_id,
             bon_dat,
             bon_id,
             kl_art_id,
             ean_kasse,
             umsatz_brutto,
			       count(*) as anzahl
      from dbp_etl_process.artbew_zeilen_stornos
      where menge < 0 and
            talon_id <> 0
	  group by 1,2,3,4,5,6,7) b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id and
     a.bon_dat = b.bon_dat and
     a.bon_id = b.bon_id and
     a.kl_art_id = b.kl_art_id and
     a.ean_kasse = b.ean_kasse and
    (-1)*a.umsatz_brutto = case
	                           when b.anzahl >= 15
                             then b.umsatz_brutto
							               else null
						               end
qualify row_number() over (partition by a.mandant_id, a.wup_id, a.bon_dat,a.bon_id, a.kl_art_id, a.umsatz_brutto order by a.bon_zeile desc) = 15
union
select a.mandant_id,
       a.wup_id,
       a.bon_dat,
       a.bon_id,
       a.kl_art_id,
       a.umsatz_brutto,
       a.bon_zeile,
       a.talon_id
from dbp_etl_process.artbew_zeilen_stornos a
join (select mandant_id,
             wup_id,
             bon_dat,
             bon_id,
             kl_art_id,
             ean_kasse,
             umsatz_brutto,
			       count(*) as anzahl
      from dbp_etl_process.artbew_zeilen_stornos
      where menge < 0 and
            talon_id <> 0
	  group by 1,2,3,4,5,6,7) b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id and
     a.bon_dat = b.bon_dat and
     a.bon_id = b.bon_id and
     a.kl_art_id = b.kl_art_id and
     a.ean_kasse = b.ean_kasse and
    (-1)*a.umsatz_brutto = case
	                           when b.anzahl >= 16
                             then b.umsatz_brutto
							               else null
						               end
qualify row_number() over (partition by a.mandant_id, a.wup_id, a.bon_dat,a.bon_id, a.kl_art_id, a.umsatz_brutto order by a.bon_zeile desc) = 16
union
select a.mandant_id,
       a.wup_id,
       a.bon_dat,
       a.bon_id,
       a.kl_art_id,
       a.umsatz_brutto,
       a.bon_zeile,
       a.talon_id
from dbp_etl_process.artbew_zeilen_stornos a
join (select mandant_id,
             wup_id,
             bon_dat,
             bon_id,
             kl_art_id,
             ean_kasse,
             umsatz_brutto,
			       count(*) as anzahl
      from dbp_etl_process.artbew_zeilen_stornos
      where menge < 0 and
            talon_id <> 0
	  group by 1,2,3,4,5,6,7) b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id and
     a.bon_dat = b.bon_dat and
     a.bon_id = b.bon_id and
     a.kl_art_id = b.kl_art_id and
     a.ean_kasse = b.ean_kasse and
    (-1)*a.umsatz_brutto = case
	                           when b.anzahl >= 17
                             then b.umsatz_brutto
							               else null
						               end
qualify row_number() over (partition by a.mandant_id, a.wup_id, a.bon_dat,a.bon_id, a.kl_art_id, a.umsatz_brutto order by a.bon_zeile desc) = 17
union
select a.mandant_id,
       a.wup_id,
       a.bon_dat,
       a.bon_id,
       a.kl_art_id,
       a.umsatz_brutto,
       a.bon_zeile,
       a.talon_id
from dbp_etl_process.artbew_zeilen_stornos a
join (select mandant_id,
             wup_id,
             bon_dat,
             bon_id,
             kl_art_id,
             ean_kasse,
             umsatz_brutto,
			       count(*) as anzahl
      from dbp_etl_process.artbew_zeilen_stornos
      where menge < 0 and
            talon_id <> 0
	  group by 1,2,3,4,5,6,7) b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id and
     a.bon_dat = b.bon_dat and
     a.bon_id = b.bon_id and
     a.kl_art_id = b.kl_art_id and
     a.ean_kasse = b.ean_kasse and
    (-1)*a.umsatz_brutto = case
	                           when b.anzahl >= 18
                             then b.umsatz_brutto
							               else null
						               end
qualify row_number() over (partition by a.mandant_id, a.wup_id, a.bon_dat,a.bon_id, a.kl_art_id, a.umsatz_brutto order by a.bon_zeile desc) = 18
union
select a.mandant_id,
       a.wup_id,
       a.bon_dat,
       a.bon_id,
       a.kl_art_id,
       a.umsatz_brutto,
       a.bon_zeile,
       a.talon_id
from dbp_etl_process.artbew_zeilen_stornos a
join (select mandant_id,
             wup_id,
             bon_dat,
             bon_id,
             kl_art_id,
             ean_kasse,
             umsatz_brutto,
			       count(*) as anzahl
      from dbp_etl_process.artbew_zeilen_stornos
      where menge < 0 and
            talon_id <> 0
	  group by 1,2,3,4,5,6,7) b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id and
     a.bon_dat = b.bon_dat and
     a.bon_id = b.bon_id and
     a.kl_art_id = b.kl_art_id and
     a.ean_kasse = b.ean_kasse and
    (-1)*a.umsatz_brutto = case
	                           when b.anzahl >= 19
                             then b.umsatz_brutto
							               else null
						               end
qualify row_number() over (partition by a.mandant_id, a.wup_id, a.bon_dat,a.bon_id, a.kl_art_id, a.umsatz_brutto order by a.bon_zeile desc) = 19
union
select a.mandant_id,
       a.wup_id,
       a.bon_dat,
       a.bon_id,
       a.kl_art_id,
       a.umsatz_brutto,
       a.bon_zeile,
       a.talon_id
from dbp_etl_process.artbew_zeilen_stornos a
join (select mandant_id,
             wup_id,
             bon_dat,
             bon_id,
             kl_art_id,
             ean_kasse,
             umsatz_brutto,
			       count(*) as anzahl
      from dbp_etl_process.artbew_zeilen_stornos
      where menge < 0 and
            talon_id <> 0
	  group by 1,2,3,4,5,6,7) b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id and
     a.bon_dat = b.bon_dat and
     a.bon_id = b.bon_id and
     a.kl_art_id = b.kl_art_id and
     a.ean_kasse = b.ean_kasse and
    (-1)*a.umsatz_brutto = case
	                           when b.anzahl >= 20
                             then b.umsatz_brutto
							               else null
						               end
qualify row_number() over (partition by a.mandant_id, a.wup_id, a.bon_dat,a.bon_id, a.kl_art_id, a.umsatz_brutto order by a.bon_zeile desc) = 20
union
select mandant_id,
       wup_id,
       bon_dat,
       bon_id,
       kl_art_id,
       umsatz_brutto,
       bon_zeile,
       talon_id
from dbp_etl_process.artbew_zeilen_stornos
where menge < 0 and
      talon_id <> 0
);