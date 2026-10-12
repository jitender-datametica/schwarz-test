/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL
#----------------------------------------------------------------------------
# History:
#  1.0  01.08.2022    Bialek, Aleksander       Initial Version Part of Liefertreue Dashboard RPA Alternative solution. AD WI: 356666 (Main WI:350713)
#
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE PROCEDURE P_LEW_MART_LEAD.P_LFT_DASH_DATA_PROCESSING()
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS '
var stmnt0 = `
SELECT Cast(CURRENT_DATE-50 as text), Cast(CURRENT_DATE-1 as text);
`
var rs0 = snowflake.createStatement({sqlText : stmnt0}).execute();
rs0.next();
var param1 = rs0.getColumnValue(1);
var param2 = rs0.getColumnValue(2);

var stmnt = `CREATE TEMPORARY TABLE p_lew_mart_lead.WE_MOV
AS
SELECT * 
FROM p_lew_core_ac.v_wawi_mov_item_wh_receiving_2
WHERE dat_formdate between x!xparam1x!x and x!xparam2x!x
ORDER BY DAT_FORMDATE, CLIENT_ID, ITEM_SID, WH_LOC_SID;
`
var stmnt = stmnt.replace(/x!x/g,"''" )
var stmnt = stmnt.replace(/param1/g, param1 )
var stmnt = stmnt.replace(/param2/g, param2 )
snowflake.createStatement({sqlText : stmnt}).execute();

var stmnt = `CREATE TEMPORARY TABLE p_lew_mart_lead.WE_DISPO
AS
select distinct
ord.client_id
,ord.loc_sid
,ord2.sup_sid
,ord.item_sid
,ord.delivery_dt
,ord2.delivery_dt as delivery_dt2
,ord.order_record_id
,rec.receipt_id_rcv
,rec.orig_receipt_id_rcv
,ord.order_status_cd 
,art_wh.PF as PF --neu
,min(rec.Tage) as mini
,max(rec.Tage) as Letzter_Tag
,case when Letzter_Tag is not null then max(rec.Tage - ord2.delivery_dt)  
			when ord2.delivery_dt >= current_date()  then 0
			else 0 
end as Max_Verspaetung
,max(Max_Status) as Max_Status
,cast( min(case when ord.order_remain_qty is not null then ord.order_remain_qty else ord.order_qty  end * cast(ord.case_factor as decimal(18,0))) as decimal(18,0)) as Order_qty_Remain
,max(ord.order_qty * cast(ord.case_factor as decimal(18,0)))  as Order_qty_orig
,zeroifnull(case when ord2.delivery_dt >= mini then sum(rec.Menge_Gesamt) else 0 end)/nullifzero(count(ord.client_id||ord.loc_sid||item_sid||ord.delivery_dt||ord.order_record_id)) as Received_on_time_qty
,zeroifnull(sum(rec.Menge_Gesamt) )/nullifzero(count(ord.client_id||ord.loc_sid||item_sid||ord.delivery_dt||ord.order_record_id)) as Received_total_qty
--,case when max(ord.order_status_cd) > 2 then 1 else 0 end as Storniert
--,Order_qty - Received_qty as Delta
from p_lew_core_ac.v_replenish_order_wh_record_pos_2 as ord
join p_lew_core_ac.v_replenish_order_wh_record_2 as ord2
	on ord2.client_id = ord.client_id
	and ord2.loc_sid = ord.loc_sid
	and ord2.order_record_id = ord.order_record_id
join p_lew_mart_Msi_ac_materialized.v_cal_calendarday_2 as tag_2
	on tag.dat_calendar = ord.delivery_dt	
join
(

select distinct


art_wh.client_id
,wh_core.wh_loc_sid
,art_wh.item_id
,art_wh.case_factor_euro as PF --neu
,max(art_wh.status_id) as Max_Status


from p_lew_mart_Msi_ac_materialized.v_itm_item_wh_2 as art_wh

	
join p_lew_mart_Msi_ac_materialized.v_org_wh_merge_2 as wh_msi
	on wh_msi.client_id = art_wh.client_id
		and wh_msi.wh_id = art_wh.wh_id


join p_lew_core_ac.v_wawi_org_wh_2 as wh_core
	on wh_core.client_id = art_wh.client_id
	and wh_msi.global_location_nr = wh_core.global_location_nr

where art_wh.status_id in (5,6,7,8,9)
group by 1,2,3,4 --neu

) as art_wh
	on art_wh.client_id = ord.client_id
	and art_wh.item_id = ord.item_sid
	and art_wh.wh_loc_sid = ord.loc_sid
	
--WE je Tag_2
left join 
(
select distinct
rec.client_id as Land_2
,rec.item_sid as Artikel_id
,rec.wh_loc_sid as Lager
,rec.dat_formdate as Tage
,rec.position_nr_rcv as pos_nr
,cy_day_sequence
,rec.receipt_id_rcv
,rec.orig_receipt_id_rcv

,0 as Anteil2
--,sum(case when rec.qty_total_rcv > 0 then rec.qty_total_rcv else 0 end ) as Menge2
,sum(rec.qty_case_rcv ) as Menge2
,sum(case when pos_nr is null then Menge2 else 0 end) over (partition by Land_2,Artikel_id,Lager,Tage) * Anteil2 as Menge_Null
,cast(Menge2 + Menge_Null as numeric(18,2)) as Menge_Gesamt

from WE_MOV as rec

join p_lew_mart_Msi_ac_materialized.v_cal_calendarday_2 as tag_2
	on tag.dat_calendar = rec.dat_formdate
		
left join
(
select distinct
client_id 
,item_sid 
,wh_loc_sid 
,dat_formdate
,position_nr_rcv
,sum(rec.qty_case_rcv) as Menge
,sum(Menge) over (partition by rec.client_id,rec.item_sid,rec.wh_loc_sid,rec.dat_formdate) as Menge_Gesamt
,Menge/nullifzero(Menge_Gesamt) *1.00 as Anteil
from WE_MOV as rec
where position_nr_rcv is not null
and rec.dat_formdate between to_date(x!xparam1x!x,x!xyyyy-mm_2-ddx!x) and to_date(x!xparam2x!x,x!xyyyy-mm_2-ddx!x)
--and client_id <>7
group by 1,2,3,4,5
) as pos
on pos.client_id = rec.client_id
and pos.item_sid = rec.item_sid
and pos.wh_loc_sid = rec.wh_loc_sid
and pos.dat_formdate = rec.dat_formdate
and pos.position_nr_rcv = rec.position_nr_rcv

where rec.receipt_pos_stock_relevant_fg = 1
and rec.receipttype_id in (1,2,3)
and rec.dat_formdate between to_date(x!xparam1x!x,x!xyyyy-mm_2-ddx!x) and to_date(x!xparam2x!x,x!xyyyy-mm_2-ddx!x)
--and rec.position_nr_rcv = 338021092001
group by 1,2,3,4,5,6,7,8

) as rec
on rec.Land_2 = ord.client_id
and rec.Artikel_id = ord.item_sid
and rec.Lager = ord.loc_sid
--and rec.cy_day_sequence between tag.cy_day_sequence and  tag.cy_day_sequence+4
and rec.pos_nr = ord.order_record_id

where ord.client_id <>7
and ord.delivery_dt between to_date(x!xparam1x!x,x!xyyyy-mm_2-ddx!x) and to_date(x!xparam2x!x,x!xyyyy-mm_2-ddx!x)
--and ord.order_status_cd <=2
and ord.order_record_id is not null
--and ord.item_sid = 1007047
group by 1,2,3,4,5,6,7,8,9,10,11 --neu
ORDER BY ITEM_SID, delivery_dt2, CLIENT_ID;
`
var stmnt = stmnt.replace(/x!x/g,"''" )
var stmnt = stmnt.replace(/param1/g, param1 )
var stmnt = stmnt.replace(/param2/g, param2 )
snowflake.createStatement({sqlText : stmnt}).execute();
  
var stmnt = `
CALL P_LEW_MART_LEAD.P_LFT_DASH_STOCK_DATA_PREP(x!xparam1x!x,x!xparam2x!x);
  `
var stmnt = stmnt.replace(/x!x/g,"''" )
var stmnt = stmnt.replace(/param1/g, param1 )
var stmnt = stmnt.replace(/param2/g, param2 )
snowflake.createStatement({sqlText : stmnt}).execute();

var stmnt = `CREATE TEMPORARY TABLE p_lew_mart_lead.v_stc_item_wh_msi_tmp
AS
SELECT	
sli.client_id                                             AS client_id,	
cry.curr_cd_from                                          AS currency_iso_cd,	
sli.dwh_cal_dt                                            AS dat_formdate,	
sli.item_sid                                              AS item_id,	
sli.price / cry.exchange_rate::DECIMAL(18,4) AS price_retail_stc_wh,	
sli.price_net  / cry.exchange_rate::DECIMAL(19,5) AS price_retail_net_stc_wh,	
sli.stock_calc_qty                                        AS qty_piece_stc_wh,	
wh.src_wh_id                                              AS wh_id,	
wh.loc_sid_wh                                             AS loc_sid_wh	
FROM p_lew_mart_lead.V_STOCK_LOCATION_ITEM_tmp_core AS sli	
INNER JOIN p_lew_bil_ac.v_warehouse_2 AS wh	
ON  sli.client_id     = wh.client_id	
AND sli.loc_sid       = wh.loc_sid_wh	
AND wh.dwh_actual_fg  = 1	
AND wh.bges_active_fg = 1	
INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist_2 AS cry	
ON  sli.client_id = cry.client_id	
/*	
# latest rate (point in history)	
*/	
AND CURRENT_DATE BETWEEN cry.active_from_dt AND cry.active_to_dt	
/*	
# latest history (version)	
*/	
AND CURRENT_DATE BETWEEN cry.dwh_valid_from AND cry.dwh_valid_to	
INNER JOIN p_lew_core_ac.v_exchange_rate_type_2 AS ert	
ON  cry.client_id       = ert.client_id	
AND cry.x_rate_type_sid = ert.x_rate_type_sid	
/*	
# reporting rate (slow moving)	
*/	
AND ert.src_kurst       = x!x@BEWEx!x	

/*	
# selection of partitions	
*/	
WHERE sli.dwh_cal_dt <= CURRENT_DATE	
AND sli.client_id < 41	
and sli.dwh_cal_dt between to_date(x!xparam1x!x,x!xyyyy-mm_2-ddx!x) and to_date(x!xparam2x!x,x!xyyyy-mm_2-ddx!x)
and cry.curr_cd_from = x!xEURx!x
GROUP BY 1,2,3,4,5,6,7,8,9;
`
var stmnt = stmnt.replace(/x!x/g,"''" )
var stmnt = stmnt.replace(/param1/g, param1 )
var stmnt = stmnt.replace(/param2/g, param2 )
snowflake.createStatement({sqlText : stmnt}).execute();

var stmnt = `
CREATE TEMPORARY TABLE p_lew_mart_lead.WE_DISPO1
as
select 
 we_dispo.CLIENT_ID
,land.country_iso_cd 
,LOC_SID
,wh_msi.wh_id
,wh_msi.wh_desc
,SUP_SID
,lief.Lief_nr
,lief.Lief_Nat
,lief.Lieferant
,art.buyer_name
,we_dispo.ITEM_SID
,art.item_id
,art.orig_item_nr
,art.orig_item_nr_int
,art.unitsize
,art.case_size_dec
,arz.item_desc2
,art.buying_list_type_desc
,itemgroup_int_id
,art.subitemgroup_id
,uwg.subitemgroup_desc
,fam.family_cd
,fam.item_family_desc
,tag.cy_week
,DELIVERY_DT
,DELIVERY_DT2
,ORDER_RECORD_ID
,RECEIPT_ID_RCV
,ORIG_RECEIPT_ID_RCV
,ORDER_STATUS_CD
,PF
,MINI
,LETZTER_TAG
,MAX_VERSPAETUNG
,MAX_STATUS
,ORDER_QTY_REMAIN
,ORDER_QTY_ORIG
,RECEIVED_ON_TIME_QTY
,RECEIVED_TOTAL_QTY
 from WE_DISPO
  join p_lew_mart_Msi_ac_materialized.v_cal_calendarday_2 as tag_2
	on tag.dat_calendar = p_lew_mart_lead.we_dispo.delivery_dt2

	
-- Land_2
join p_lew_mart_Msi_ac_materialized.v_ref_country_2 as land_2
	on land.country_id = p_lew_mart_lead.we_dispo.client_id
	
	
join p_lew_mart_Msi_ac_materialized.v_itm_item_act_2 as art_2
	on art.client_id = we_dispo.client_id
	and art.item_id = we_dispo.item_sid
	--and art.buying_list_type_id not in(7,8)
	
--Artikelbezeichnung
join 
(
select distinct

arz.client_id
,arz.item_id
,art.orig_item_nr_int
,arz2.item_desc as Eins
,arz.item_desc as Zwei
,case when art.orig_item_nr_int is not null then arz2.item_desc else arz.item_desc end as item_desc2

from p_lew_mart_Msi_ac_materialized.v_itm_item_act_2 as art_2


left join p_lew_mart_Msi_ac_materialized.v_itm_item_desc_2 as arz
	on arz.client_id = art.client_id
	and arz.item_id = art.item_id

left join
(
select distinct
arz.client_id
,art.orig_item_nr_int
,item_desc
,min(arz.client_id) over (partition by art.orig_item_nr_int) as Min_client_id
,row_number() over (partition by arz.client_id,art.orig_item_nr_int order by arz.client_id asc) as zeile
,case when art.orig_item_nr_int is not null and min_client_id = arz.client_id then 1 else 0 end as flag


from p_lew_mart_Msi_ac_materialized.v_itm_item_desc_2 as arz

join p_lew_mart_Msi_ac_materialized.v_itm_item_act_2 as art_2
	on art.client_id = arz.client_id
	and art.item_id = arz.item_id


group by 1,2,3

/*Snowflake: qualify nach group by*/

qualify flag = 1
and zeile = 1
) as arz2
on arz2.orig_item_nr_int = art.orig_item_nr_int




group by 1,2,3,4,5
) as arz
on arz.item_id = art.item_id
and arz.client_id = art.client_id
	
join p_lew_core_ac.v_wawi_org_wh_2 as wh_core
	on wh_core.client_id = p_lew_mart_lead.we_dispo.client_id
	and wh_core.wh_loc_sid = p_lew_mart_lead.we_dispo.loc_sid
	and wh_core.dat_rec_end = datex!x9999-12-31x!x
	
join p_lew_mart_Msi_ac_materialized.v_org_wh_merge_2 as wh_msi
	on wh_msi.client_id = wh_core.client_id
	and wh_msi.global_location_nr = wh_core.global_location_nr
	and wh_msi.aspect_id = 1
	
join p_lew_core_ac.v_wawi_itm_wh_orderinformation_2 as ord_inf
	on ord_inf.client_id = art.client_id
	and ord_inf.item_sid = art.item_id
	and ord_inf.wh_loc_sid = wh_core.wh_loc_sid
	and p_lew_mart_lead.we_dispo.delivery_dt between ord_inf.dat_rec_start and ord_inf.dat_rec_end
	
join p_lew_core_ac.v_wawi_ref_itm_dispo_group_2 as ord_inf2
	on ord_inf2.client_id = ord_inf.client_id
	and ord_inf2.dispo_group_id = ord_inf.dispo_group_id
	and ord_inf2.language_id = 7
	
	
-- Lieferant
left join
(
select

lief.client_id
,lief.supplier_id
,lief.orig_supplier_nr as Lief_Nat
,lief.supplier_id_int
--,lief.main_negot_cntry_cd
,lief.delivery_item_cd
,lief_name.namen as Eins
,lief.supplier_name as Zwei
,lief2.supplier_id_int as lief_nr
,item_id
/*Snowflake: replace statt oreplace */
,case when lief.supplier_name is not null then replace(lief.supplier_name,CHR(9), x!xx!x) else replace(lief_name.namen,CHR(9), x!xx!x)  end as Lieferant

from p_lew_mart_msi_ac_materialized.v_sup_supplier_2 as lief

left join p_lew_mart_Msi_ac_materialized.v_sup_supplier_int_2 as lief2
	on lief2.client_id = lief.client_id
	and lief2.supplier_id = lief.supplier_id
	
left join
(
select distinct
lief.client_id
,lief.supplier_id_int
,supplier_desc_int as namen
,min(lief.client_id) over (partition by lief.supplier_id_int) as min_client_id
,row_number() over (partition by lief.client_id,lief.supplier_id_int order by lief.client_id asc) as zeile
,case when lief.client_id = min_client_id then 1 else 0 end as Flag

from p_lew_mart_msi_ac_materialized.v_sup_supplier_int_2 as lief

group by 1,2,3
qualify Flag = 1
and zeile = 1
) as lief_name
on lief_name.supplier_id_int = lief.supplier_id_int

--and lief_name.supplier_id = lief.supplier_id

	
join
(
select
client_id
,item_id
,supplier_id
,max(dat_formdate) as max_date

from p_lew_mart_Msi_ac_materialized.v_supplier_item_2

group by 1,2,3
) as lief_art
on lief_art.client_id = lief.client_id
and lief_art.supplier_id = lief.supplier_id

--where lief2.supplier_id_int <> 12272

group by 1,2,3,4,5,6,7,8,9

) as lief
on lief.client_id = art.client_id
and lief.item_id = art.item_id
and lief.supplier_id = p_lew_mart_lead.we_dispo.sup_sid

-- UWG Bezeichnung
join p_lew_mart_Msi_ac_materialized.v_itm_subitemgroup_desc_2 as uwg
	on uwg.subitemgroup_id = art.subitemgroup_id
	
join p_lew_mart_Msi_ac_materialized.v_itm_subitemgroup_2 as uwg2
	on uwg2.subitemgroup_id = uwg.subitemgroup_id
	
-- Artikelfamilie und Bezeichnung
join p_lew_mart_Msi_ac_materialized.v_itm_familygroup_2 as fam
	on fam.client_id = art.client_id
	and fam.item_familygroup_id = art.item_familygroup_id
	and fam.subitemgroup_id = art.subitemgroup_id
	
	
	
left join
--Fehlartikel Lager laut Meldung
(
select distinct
miss.client_id
,miss.item_id
,miss.wh_id_pp
,tag.cy_week
,miss.dat_sys
,count(distinct wh_id_pp) Anzahl_missing

from p_lew_mart_msi_ac_materialized.v_itm_miss_item_wh_detail_2 as miss

join p_lew_mart_Msi_ac_materialized.v_cal_calendarday_2 as tag_2
	on tag.dat_calendar = miss.dat_sys

left join
(
select distinct
missing_reason_cd
,missing_reason_desc
from p_lew_mart_msi_ac_materialized.v_itm_miss_item_wh_detail_2 as miss

where client_id <>7
and dat_sys >= datex!x2020-01-01x!x
) as reason
on reason.missing_reason_cd = miss.missing_reason_cd

where miss.dat_sys between to_date(x!xparam1x!x,x!xyyyy-mm_2-ddx!x) and to_date(x!xparam2x!x,x!xyyyy-mm_2-ddx!x)
and miss.temp_miss_fg = 0

group by 1,2,3,4,5
) as miss
on miss.client_id = art.client_id
and miss.item_id = art.item_id
and miss.wh_id_pp = wh_msi.wh_id
and miss.cy_week = tag.cy_week
and miss.dat_sys = p_lew_mart_lead.we_dispo.delivery_dt2
ORDER BY  client_id
,ART.item_id
,art.orig_item_nr
,wh_id
,cy_week
,delivery_dt2;
  `
var stmnt = stmnt.replace(/x!x/g,"''" )
var stmnt = stmnt.replace(/param1/g, param1 )
var stmnt = stmnt.replace(/param2/g, param2 )
snowflake.createStatement({sqlText : stmnt}).execute();

var stmnt = `CREATE TEMPORARY TABLE p_lew_mart_lead.EJR_DATA
AS
select
client_id
,cy_week
,cy_week_sequence
,wh_id
,byr
,item_id
,avg(case when ejr.cy_week_sequence >= ejr.Max_Woche_Sequenz - 4 then ejr.Abverkauf_Stueck else 0 end) as Abverkauf_Stueck 

from
(
select
client_id
,cy_week
,cy_week_sequence
,ejr.wh_id
,byr
,item_id
,max(cy_week) over (partition by client_id) as Max_Woche
,max(cy_week_sequence) over (partition by client_id) as Max_Woche_Sequenz
,cast(sum(ejr.qty_piece_ejr_asis + ejr.qty_weight_ejr_asis) as decimal(18,0)) as Abverkauf_Stueck

from p_lew_mart_msi_ac_materialized.v_agg_wh_day_item_ejr_asis_2 as ejr

full outer join p_lew_mart_Msi_ac_materialized.v_cal_calendarday_2 as tag1	
	on tag1.dat_calendar = ejr.dat_formdate


where ejr.dat_formdate between datex!x2020-06-19x!x and to_date(x!xparam2x!x,x!xyyyy-mm_2-ddx!x)
and ejr.currency_iso_cd = x!xEURx!x


group by 1,2,3,4,5,6
) as ejr

group by 1,2,3,4,5,6
ORDER BY CLIENT_ID, ITEM_ID, WH_ID, CY_WEEK;
  `
var stmnt = stmnt.replace(/x!x/g,"''" )
var stmnt = stmnt.replace(/param1/g, param1 )
var stmnt = stmnt.replace(/param2/g, param2 )
snowflake.createStatement({sqlText : stmnt}).execute();

var stmnt = `CREATE TEMPORARY TABLE p_lew_mart_lead.ALM_DATA
AS
select
client_id
,cy_week
,cy_week_sequence
,wh_id
,item_id
,avg(case when angel.cy_week_sequence >= angel.Max_Woche_Sequenz - 4 then angel.Menge_angel else 0 end) as Menge_angel

from
(
select	
angel.client_id
,angel.wh_id
,angel.item_id
,cy_week
,cy_week_sequence
,sum(angel.qty_total_del_asis) as Menge_angel
,max(cy_week) over (partition by client_id) as Max_Woche
,max(cy_week_sequence) over (partition by client_id) as Max_Woche_Sequenz

from p_lew_mart_msi_ac_materialized.v_agg_wh_day_item_del_asis_2	as angel

full outer join p_lew_mart_Msi_ac_materialized.v_cal_calendarday_2 as tag1	
	on tag1.dat_calendar = angel.dat_formdate

where angel.currency_iso_cd = x!xEURx!x
and angel.dat_formdate between datex!x2020-06-19x!x and to_date(x!xparam2x!x,x!xyyyy-mm_2-ddx!x)

group by 1,2,3,4,5
) as angel

group by 1,2,3,4,5
ORDER BY CLIENT_ID, ITEM_ID, WH_ID, CY_WEEK;
  `
var stmnt = stmnt.replace(/x!x/g,"''" )
var stmnt = stmnt.replace(/param1/g, param1 )
var stmnt = stmnt.replace(/param2/g, param2 )
snowflake.createStatement({sqlText : stmnt}).execute();

var stmnt = `CREATE TEMPORARY TABLE p_lew_mart_lead.LF_DASH_TMP_MIS_DATA
AS
select
 WE_DISPO1.country_iso_cd as Land_2 --ok
,WE_DISPO1.wh_id as Gesellschaft_Nr --ok
,WE_DISPO1.wh_desc as Gesellschaft_Name --ok
,WE_DISPO1.Lief_nr as Lieferanten_Nummer --ok
,WE_DISPO1.Lief_Nat as Nationale_Lieferanten_Nummer
,WE_DISPO1.Lieferant as Lieferant --ok
,WE_DISPO1.buyer_name as Einkaeufer --ok
,order_record_id as Bestellnummer --ok
,WE_DISPO1.itemgroup_int_id as WGI_id --ok
,case when WGI_id = 10 then x!xO_Gx!x
				when WGI_id = 20  then x!xBlumenx!x
				when WGI_id = 30 then x!xFF_FGx!x
				when WGI_id = 32 then x!xFrischfischx!x
				when WGI_id = 40 then x!xTikox!x
				when WGI_id = 50 then x!xKuehlungx!x
				when WGI_Id = 60 then  x!xFood_TSx!x
				when WGI_id = 70 then x!xNon_Foodx!x
				when WGI_id = 90 then x!xBake-Offx!x
end as WGI
,WE_DISPO1.subitemgroup_id as UWG_id --ok
,WE_DISPO1.subitemgroup_desc as UWG --ok
,WE_DISPO1.family_cd as Artikelfamilie_id --ok
,WE_DISPO1.item_family_desc as Artikelfamilie --ok
,WE_DISPO1.orig_item_nr_int as IAN --ok
,WE_DISPO1.orig_item_nr as NAN --ok
,WE_DISPO1.unitsize as Grammatur --ok
,WE_DISPO1.case_size_dec as Kolliinhalt --ok
--,1 * art.case_euro as Palettenfaktor --ok --neu
,1 * WE_DISPO1.PF as Palettenfaktor --neu
,WE_DISPO1.item_desc2 as Artikel_2 --ok
,WE_DISPO1.buying_list_type_desc as Artikelart --ok
,WE_DISPO1.cy_week as woche_2 --ok
,order_status_cd as Status_Bestellung
,max(Max_Status) as Status_Artikel
--,max(Storniert) as Storniert
,sum(order_qty_orig) as Bestellmenge --ok
,sum(order_qty_remain) as Korrigierte_Bestellmenge 
,sum(Received_on_time_qty) as Wareneingang_Puenktlich --ok
,sum(Received_total_qty) - Wareneingang_Puenktlich as Wareneingange_Verspaetet --ok
,100.00 * sum(Received_total_qty) / nullifzero( sum(order_qty_orig)) as Anteil_Lieferung --ok
,max(WE_DISPO1.Max_Verspaetung) as Tage_Verspaetung --ok
,max(Letzter_Tag) as Letzter_Tag_Anlieferung --ok
,max(delivery_dt) as Geplante_Anlieferung --ok
,max(delivery_dt2) as Urspruenglich_Geplante_Anlieferung --ok
,avg(miss.Anzahl_missing) as Fehlartikel --ok
,zeroifnull(avg( fa.Bestand_Lager2 )) as Bestand_Lager_1_Tag_vor_geplanter_Anlieferung --ok
,avg(angel.Menge_angel)/nullifzero(Kolliinhalt) as AVG_Abgang_Lager_4_Wochen
,avg(ejr.Abverkauf_Stueck)/nullifzero(Kolliinhalt) as AVG_Abverkauf_4_Wochen --ok
,Bestand_Lager_1_Tag_vor_geplanter_Anlieferung / nullifzero(AVG_Abgang_Lager_4_Wochen) * 7 as Reichweite_Tage
,sum(Fehlartikel) over (partition by Woche_2,NAN,Land_2) as Anzahl_Gesellschaften_mit_Fehlartikel

FROM WE_DISPO1
left join
--Fehlartikel Lager laut Meldung
(
select distinct
miss.client_id
,miss.item_id
,miss.wh_id_pp
,tag.cy_week
,miss.dat_sys
,count(distinct wh_id_pp) Anzahl_missing

from p_lew_mart_msi_ac_materialized.v_itm_miss_item_wh_detail_2 as miss

join p_lew_mart_Msi_ac_materialized.v_cal_calendarday_2 as tag_2
	on tag.dat_calendar = miss.dat_sys

left join
(
select distinct
missing_reason_cd
,missing_reason_desc
from p_lew_mart_msi_ac_materialized.v_itm_miss_item_wh_detail_2 as miss

where client_id <>7
and dat_sys >= datex!x2020-01-01x!x
) as reason
on reason.missing_reason_cd = miss.missing_reason_cd

where miss.dat_sys between to_date(x!xparam1x!x,x!xyyyy-mm_2-ddx!x) and to_date(x!xparam2x!x,x!xyyyy-mm_2-ddx!x)
and miss.temp_miss_fg = 0

group by 1,2,3,4,5
) as miss
on miss.client_id = WE_DISPO1.client_id
and miss.item_id = WE_DISPO1.item_id
and miss.wh_id_pp = WE_DISPO1.wh_id
and miss.cy_week = WE_DISPO1.cy_week
and miss.dat_sys = WE_DISPO1.delivery_dt2


left join
--Bestand Lager
(
select
fa.client_id
,art.orig_item_nr
,fa.wh_id
,tag.byr
,tag.cy_week
,fa.dat_formdate
--,count(fa.wh_id) as Anzahl_Gesellschaften
--,100.00* count( case when fa.qty_piece_stc_wh < 50 then fa.wh_id else NULL end)/nullifzero(Anzahl_Gesellschaften) as Anteil_Fehl
,sum(case when fa.qty_piece_stc_wh >0  then fa.qty_piece_stc_wh / nullifzero(art.case_size_dec) else 0 end) as Bestand_Lager2

from p_lew_mart_lead.v_stc_item_wh_msi_tmp as fa

join p_lew_mart_Msi_ac_materialized.v_itm_item_act_2 as art_2
	on art.client_id = fa.client_id
	and art.item_id = fa.item_id

join p_lew_mart_Msi_ac_materialized.v_cal_calendarday_2 as tag_2
	on tag.dat_calendar = fa.dat_formdate

where fa.currency_iso_cd = x!xEURx!x
and fa.dat_formdate between to_date(x!xparam1x!x,x!xyyyy-mm_2-ddx!x) and to_date(x!xparam2x!x,x!xyyyy-mm_2-ddx!x)

group by 1,2,3,4,5,6

/*Snowflake: having nach group by */
having Bestand_Lager2 > 0

) as fa
on fa.client_id = WE_DISPO1.client_id
and fa.orig_item_nr = WE_DISPO1.orig_item_nr
and fa.dat_formdate = WE_DISPO1.delivery_dt2 - 1
and fa.wh_id = WE_DISPO1.wh_id

left join
-- Abverkaufte Menge je Land_2, Artikel_2 und Tag_2
p_lew_mart_lead.EJR_DATA as ejr
on ejr.client_id = WE_DISPO1.client_id
and ejr.item_id = WE_DISPO1.item_sid
and ejr.wh_id = WE_DISPO1.wh_id
and ejr.cy_week = WE_DISPO1.cy_week


left join
-- Angelieferte Menge je Filiale
p_lew_mart_lead.ALM_DATA as angel
on angel.client_id = WE_DISPO1.client_id
and angel.wh_id = WE_DISPO1.wh_id
and angel.cy_week = WE_DISPO1.cy_week
and angel.item_id = WE_DISPO1.item_sid


	
--where WGI_id <> 3

--where art.orig_item_nr = 34381
	


group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23

/*Snowflake: having nach group by */
having Wareneingange_Verspaetet >= 0
and (Bestellmenge > 0 or (Bestellmenge = 0 and Korrigierte_Bestellmenge >0))
and (Tage_Verspaetung > 0 or Anteil_Lieferung < 100 or Fehlartikel is not null )
--and Bestellnummer = x!x123126032101x!x
and Status_Bestellung <= 9;  
  `
var stmnt = stmnt.replace(/x!x/g,"''" )
var stmnt = stmnt.replace(/param1/g, param1 )
var stmnt = stmnt.replace(/param2/g, param2 )
snowflake.createStatement({sqlText : stmnt}).execute();

var stmnt = `CREATE TEMPORARY TABLE p_lew_mart_lead.MIS_dat0
as
select 
  Land_2
, Gesellschaft_Nr
, Gesellschaft_Name
, Lieferanten_Nummer
, Nationale_Lieferanten_Nummer
, Lieferant
, Einkaeufer
, Bestellnummer
, WGI_id
, WGI
, UWG_id
, UWG
, Artikelfamilie_id
, Artikelfamilie
, M.IAN
, NAN
, Grammatur
, Kolliinhalt
, Palettenfaktor
, Artikel_2
, Artikelart
, Case when IAN is null then x!xKEINE IANx!x 
       else x!xMARKE?x!x end Transportweg_kurz
, Case when IAN is null then x!xKEINE IANx!x 
       else x!xMARKE?x!x end Transportweg_lang
, woche_2
, Status_Bestellung
, Status_Artikel
, CASE 
        WHEN LETZTER_TAG_ANLIEFERUNG IS NULL
        AND COALESCE(Status_Bestellung,9) = 9
        THEN NULL
  ELSE Bestellmenge
  END Bestellmenge
, CASE 
        WHEN LETZTER_TAG_ANLIEFERUNG IS NULL
        AND COALESCE(Status_Bestellung,9) = 9
        THEN NULL
  ELSE Korrigierte_Bestellmenge
  END Korrigierte_Bestellmenge
, CASE 
        WHEN LETZTER_TAG_ANLIEFERUNG IS NULL
        AND COALESCE(Status_Bestellung,9) = 9
        THEN NULL
  ELSE WARENEINGANG_PUENKTLICH
  END WARENEINGANG_PUENKTLICH 
, CASE 
        WHEN LETZTER_TAG_ANLIEFERUNG IS NULL
        AND COALESCE(Status_Bestellung,9) = 9
        THEN NULL
  ELSE WARENEINGANGE_VERSPAETET
  END WARENEINGANGE_VERSPAETET 
, CASE 
        WHEN LETZTER_TAG_ANLIEFERUNG IS NULL
        AND COALESCE(Status_Bestellung,9) = 9
        THEN NULL
  ELSE Anteil_Lieferung
  END Anteil_Lieferung  
, CASE 
        WHEN LETZTER_TAG_ANLIEFERUNG IS NULL
        AND COALESCE(Status_Bestellung,9) = 9
        THEN NULL
  ELSE Tage_Verspaetung
  END Tage_Verspaetung  
, CASE 
        WHEN LETZTER_TAG_ANLIEFERUNG IS NULL
        AND COALESCE(Status_Bestellung,9) = 9
        THEN NULL
  ELSE Letzter_Tag_Anlieferung
  END Letzter_Tag_Anlieferung
, CASE 
        WHEN LETZTER_TAG_ANLIEFERUNG IS NULL
        AND COALESCE(Status_Bestellung,9) = 9
        THEN NULL
  ELSE Geplante_Anlieferung
  END Geplante_Anlieferung 
, CASE 
        WHEN LETZTER_TAG_ANLIEFERUNG IS NULL
        AND COALESCE(Status_Bestellung,9) = 9
        THEN NULL
  ELSE URSPRUENGLICH_GEPLANTE_ANLIEFERUNG
  END URSPRUENGLICH_GEPLANTE_ANLIEFERUNG  
, CASE 
        WHEN LETZTER_TAG_ANLIEFERUNG IS NULL
        AND COALESCE(Status_Bestellung,9) = 9
        THEN NULL
  ELSE Fehlartikel
  END Fehlartikel  
, CASE 
        WHEN LETZTER_TAG_ANLIEFERUNG IS NULL
        AND COALESCE(Status_Bestellung,9) = 9
        THEN NULL
  ELSE Bestand_Lager_1_Tag_vor_geplanter_Anlieferung
  END Bestand_Lager_1_Tag_vor_geplanter_Anlieferung   
, CASE 
        WHEN LETZTER_TAG_ANLIEFERUNG IS NULL
        AND COALESCE(Status_Bestellung,9) = 9
        THEN NULL
  ELSE AVG_Abgang_Lager_4_Wochen
  END AVG_Abgang_Lager_4_Wochen  
, CASE 
        WHEN LETZTER_TAG_ANLIEFERUNG IS NULL
        AND COALESCE(Status_Bestellung,9) = 9
        THEN NULL
  ELSE  AVG_Abverkauf_4_Wochen
  END  AVG_Abverkauf_4_Wochen 
, CASE 
        WHEN LETZTER_TAG_ANLIEFERUNG IS NULL
        AND COALESCE(Status_Bestellung,9) = 9
        THEN NULL
  ELSE  Reichweite_Tage
  END  Reichweite_Tage 
, CASE 
        WHEN LETZTER_TAG_ANLIEFERUNG IS NULL
        AND COALESCE(Status_Bestellung,9) = 9
        THEN NULL
  ELSE  Anzahl_Gesellschaften_mit_Fehlartikel
  END  Anzahl_Gesellschaften_mit_Fehlartikel  
, Case when IAN is null then x!xKEINE IANx!x 
       else x!xMARKE?x!x end LAND_VERHANDELT
, Case when IAN is null then x!xKEINE IANx!x 
       else x!xMARKE?x!x end EK_EKS  
FROM p_lew_mart_lead.LF_DASH_TMP_MIS_DATA m
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43
ORDER BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43;
`
var stmnt = stmnt.replace(/x!x/g,"''" )
snowflake.createStatement({sqlText : stmnt}).execute();

var stmnt = `CREATE TEMPORARY TABLE p_lew_mart_lead.LT_EKS_DATA
AS
SELECT 
 row_number() over (order by Cast(IAN as INTEGER), Cast(EKS_nummer as INTEGER), Cast(INT_LIEFERANTENNUMMER as INTEGER) ) rn
,BELIEFERUNGSLAND
,Int_Lieferantennummer
,ian
,Cast(EKS_NUMMER as integer) as eks_nr
,Transportweg_kurz
,Transportweg_LANG
,LAND_VERHANDELT
,EINKAUFER
FROM P_LEW_PRECORE.T_CACHE_EKS_FILE_2 A
where dwh_load_id = (select max(dwh_load_id) from P_LEW_PRECORE.T_CACHE_EKS_FILE_2);
`
var stmnt = stmnt.replace(/x!x/g,"''" )
snowflake.createStatement({sqlText : stmnt}).execute();

var stmnt = `CREATE TEMPORARY TABLE p_lew_mart_lead.LT_EKS_DATA_1
AS
WITH MIN_RN AS (
SELECT 
 BELIEFERUNGSLAND
,Int_Lieferantennummer
,MIN(rn) MIN_RN
FROM p_lew_mart_lead.LT_EKS_DATA 
GROUP BY 1,2
)
SELECT a.*
FROM p_lew_mart_lead.LT_EKS_DATA a
JOIN MIN_RN b
ON a.BELIEFERUNGSLAND = b.BELIEFERUNGSLAND
and a.Int_Lieferantennummer = b.Int_Lieferantennummer
and a.rn = b.MIN_RN;
`
var stmnt = stmnt.replace(/x!x/g,"''" )
snowflake.createStatement({sqlText : stmnt}).execute();

var stmnt = `CREATE TEMPORARY TABLE p_lew_mart_lead.LT_dash_cube_dat
AS
select 
  Land_2
, Gesellschaft_Nr
, Gesellschaft_Name
, Lieferanten_Nummer
, Nationale_Lieferanten_Nummer
, Lieferant
, Einkaeufer
, Bestellnummer
, WGI_id
, WGI
, UWG_id
, UWG
, Artikelfamilie_id
, Artikelfamilie
, m.IAN
, NAN
, Grammatur
, Kolliinhalt
, Palettenfaktor
, Artikel_2
, Artikelart
, MIN(Coalesce(e.Transportweg_kurz,e1.Transportweg_kurz||x!x*x!x,m.Transportweg_kurz)) Transportweg_kurz
, MIN(Coalesce(e.Transportweg_lang,e1.Transportweg_lang||x!x*x!x,m.Transportweg_lang)) Transportweg_lang
, woche_2
, Status_Bestellung
, Status_Artikel
, Bestellmenge
, Korrigierte_Bestellmenge
, WARENEINGANG_PUENKTLICH 
, WARENEINGANGE_VERSPAETET 
, Anteil_Lieferung  
, Tage_Verspaetung  
, Letzter_Tag_Anlieferung
, Geplante_Anlieferung
, URSPRUENGLICH_GEPLANTE_ANLIEFERUNG
, Fehlartikel
, Bestand_Lager_1_Tag_vor_geplanter_Anlieferung
, AVG_Abgang_Lager_4_Wochen
, AVG_Abverkauf_4_Wochen
, Reichweite_Tage
, Anzahl_Gesellschaften_mit_Fehlartikel
, MIN(Coalesce(e.LAND_VERHANDELT,e1.LAND_VERHANDELT||x!x*x!x,m.LAND_VERHANDELT)) LAND_VERHANDELT
, MIN(Coalesce(e.EINKAUFER,e1.EINKAUFER||x!x*x!x,m.EK_EKS))  EK_EKS
FROM MIS_dat0 m
left JOIN LT_EKS_DATA e
ON LAND_2=BELIEFERUNGSLAND
and Lieferanten_Nummer= INT_LIEFERANTENNUMMER
and m.IAN = e.IAN
left JOIN LT_EKS_DATA_1 e1
ON m.LAND_2=e1.BELIEFERUNGSLAND
and Lieferanten_Nummer= e1.INT_LIEFERANTENNUMMER
GROUP BY   Land_2
, Gesellschaft_Nr
, Gesellschaft_Name
, Lieferanten_Nummer
, Nationale_Lieferanten_Nummer
, Lieferant
, Einkaeufer
, Bestellnummer
, WGI_id
, WGI
, UWG_id
, UWG
, Artikelfamilie_id
, Artikelfamilie
, m.IAN
, NAN
, Grammatur
, Kolliinhalt
, Palettenfaktor
, Artikel_2
, Artikelart
, woche_2
, Status_Bestellung
, Status_Artikel
, Bestellmenge
, Korrigierte_Bestellmenge
, WARENEINGANG_PUENKTLICH 
, WARENEINGANGE_VERSPAETET 
, Anteil_Lieferung  
, Tage_Verspaetung  
, Letzter_Tag_Anlieferung
, Geplante_Anlieferung
, URSPRUENGLICH_GEPLANTE_ANLIEFERUNG
, Fehlartikel
, Bestand_Lager_1_Tag_vor_geplanter_Anlieferung
, AVG_Abgang_Lager_4_Wochen
, AVG_Abverkauf_4_Wochen
, Reichweite_Tage
, Anzahl_Gesellschaften_mit_Fehlartikel;
`
var stmnt = stmnt.replace(/x!x/g,"''" )
snowflake.createStatement({sqlText : stmnt}).execute();

var stmnt = `CREATE OR REPLACE TRANSIENT TABLE P_LEW_MART_LEAD.lftr_dash_dataset
AS SELECT client_id, a.* 
FROM p_lew_mart_lead.LT_dash_cube_dat A
JOIN p_lew_mart_Msi_ac.v_ref_client_lead_2 b
ON b.COUNTRY_ISO_CD= a.LAND_2;
`
var stmnt = stmnt.replace(/x!x/g,"''" )
snowflake.createStatement({sqlText : stmnt}).execute();

';