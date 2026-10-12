INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
movement_ref_number,
authority_country_location_sid,
importer_party_sid,
importer_declarant_party_sid,
broker_declarant_party_sid,
dispatch_country_location_sid,
import_location_sid,
transport_type_cd,
transport_route_type_cd,
transport_country_location_sid,
entry_tmsp,
entry_dt,
acceptance_dt,
clearance_tmsp,
clearance_dt,
consignor_party_sid,
consignor_name,
trader_reference,
customs_val,
total_duty_val,
total_vat_val,
total_vat_paid_val,
total_cap_val,
total_excise_val,
invoice_auth_country_curr_cd,
invoice_auth_country_val,
invoice_trust_curr_cd,
invoice_trust_val,
customs_declaration_type_cd,
paying_agent_number,
total_packages_cnt,
declaration_ucr,
first_deferment,
second_deferment,
air_transport_adjust_cost_curr_cd,
air_transport_adjust_cost_val,
vat_adjustment_curr_cd,
vat_adjustment_val,
transport_adjust_cost_curr_cd,
transport_adjust_cost_val,
	DWH_SRC_FILE_NAME,
	DWH_SRC_1_TMSP,
	DWH_MAPPING_TMSP,
	TF_ERROR_FG,
	DELETED_FG,
	RECORD_ID,
DWH_VALID_FG,
	FILENAME 
)
SELECT 
h.entry_identifier AS movement_ref_number,
gb_loc.location_sid authority_country_location_sid,
--COALESCE(p1.party_sid, -1) importer_party_sid,
coalesce(NULLIF(con.importer_party_sid,-1), p4.party_sid, -1) importer_party_sid,
COALESCE(p2.party_sid, -1) importer_declarant_party_sid,
COALESCE(p3.party_sid, -1) broker_declarant_party_sid,
COALESCE(L1.LOCATION_SID, -1) dispatch_country_location_sid,
COALESCE(L2.LOCATION_SID, -1) import_location_sid,
COALESCE(tt.transport_type_cd,'UNKNOWN') transport_type_cd,
COALESCE(tt.transport_route_type_cd,'BEFORE_IMPORT') transport_route_type_cd,
COALESCE(lc.LOCATION_SID,-1) transport_country_location_sid,
--entry_date entry_tmsp,
case 
when length(entry_date)=10 and substring(trim(entry_date),3,1)='/' then to_timestamp_tz(substring(entry_date,1,10)||' 00:00:00' , 'DD/MM_2/YYYY Hh24:Mi:SS') 
when length(entry_date)=10 and substring(trim(entry_date),5,1)='-' then to_timestamp_tz(substring(entry_date,1,10)||' 00:00:00' , 'YYYY-MM_2-DD Hh24:Mi:SS')
when substring(trim(entry_date),3,1)='/' then to_timestamp_tz(substring(entry_date,1,19) , 'DD/MM_2/YYYY Hh24:Mi:SS') 
when substring(trim(entry_date),5,1)='-' then to_timestamp_tz(substring(entry_date,1,19) , 'YYYY-MM_2-DD Hh24:Mi:SS') end entry_tmsp,
case when substring(trim(entry_date),3,1)='/' then to_date(substring(entry_date,1,10) , 'DD/MM_2/YYYY') 
else to_date(substring(entry_date,1,10) , 'YYYY-MM_2-DD') end ,
case 
when COALESCE(nullif(acceptance_date,'NULL'),'1900-12-31')='1900-12-31' then '1900-12-31' 
when substring(trim(acceptance_date),3,1)='/' then to_date(substring(acceptance_date,1,10) , 'DD/MM_2/YYYY') 
else to_date(substring(acceptance_date,1,10) , 'YYYY-MM_2-DD') end acceptance_dt,

--h.clearance_date clearance_tmsp,

case 
when length(h.clearance_date)=10 and substring(trim(h.clearance_date),3,1)='/' then to_timestamp_tz(substring(h.clearance_date,1,10)||' 00:00:00' , 'DD/MM_2/YYYY Hh24:Mi:SS') 
when length(h.clearance_date)=10 and substring(trim(h.clearance_date),5,1)='-' then to_timestamp_tz(substring(h.clearance_date,1,10)||' 00:00:00' , 'YYYY-MM_2-DD Hh24:Mi:SS')
when substring(trim(h.clearance_date),3,1)='/' then to_timestamp_tz(substring(h.clearance_date,1,19) , 'DD/MM_2/YYYY Hh24:Mi:SS') 
when substring(trim(h.clearance_date),5,1)='-' then to_timestamp_tz(substring(h.clearance_date,1,19) , 'YYYY-MM_2-DD Hh24:Mi:SS') end clearance_tmsp,

case when substring(trim(h.clearance_date),3,1)='/' then to_date(substring(h.clearance_date,1,10) , 'DD/MM_2/YYYY') 
else to_date(substring(h.clearance_date,1,10) , 'YYYY-MM_2-DD') end clearance_dt,
COALESCE(PK.PARTY_SID,-1) consignor_party_sid,
i.consignor consignor_name,
coalesce(NULLIF(h.declarant_reference,'NULL'), NULLIF(br.trader_reference,'NULL')) trader_reference,
try_cast(Customs_Value as DECIMAL(38,5)) customs_val,
try_cast(total_duty as DECIMAL(38,5)) total_duty_val,
try_cast(total_vat_value as DECIMAL(38,5)) total_vat_val,
try_cast(total_vat_paid as DECIMAL(38,5)) total_vat_paid_val,
try_cast(total_cap as DECIMAL(38,5)) total_cap_val,
try_cast(total_excise as DECIMAL(38,5)) total_excise_val,
'GBP' invoice_auth_country_curr_cd,
try_cast(Invoice_Total_GBP as DECIMAL(38,5)) invoice_auth_country_val,
COALESCE(nullif(Invoice_Currency,'NULL'),'-1') invoice_trust_curr_cd,
try_cast(Invoice_Total as DECIMAL(38,5)) invoice_trust_val,
COALESCE(Declaration_Category,'-1')customs_declaration_type_cd,
NULLIF(PAYING_AGENT_EORI,'NULL')  paying_agent_number,
COALESCE(try_cast(Total_Packages as DECIMAL(38,5)), 0) total_packages_cnt,
DUCR declaration_ucr,
try_to_number(Deferment_1) first_deferment,
try_to_number(Deferment_2) second_deferment,
COALESCE(case when AIR_TRANSPORT_COST_ADJUSTMENT_CURRENCY = 'NULL' then NULL else AIR_TRANSPORT_COST_ADJUSTMENT_CURRENCY end ,'-1') air_transport_adjust_cost_curr_cd,
try_cast(AIR_TRANSPORT_COST_ADJUSTMENT as DECIMAL(38,5)) air_transport_adjust_cost_val,
COALESCE(nullif (VAT_ADJUSTMENT_CURRENCY,'NULL'),'-1') vat_adjustment_curr_cd,
try_cast(VAT_VALUE_ADJUSTMENT as DECIMAL(38,5)) vat_adjustment_val,
COALESCE(NULLIF(TRANSPORT_COST_ADJUSTMENT_CURRENCY,'NULL'),'-1') transport_adjust_cost_curr_cd,
try_cast(TRANSPORT_COST_ADJUSTMENT as DECIMAL(38,5)) transport_adjust_cost_val,
COALESCE(h.DWH_SRC_FILE_NAME,'na') AS DWH_SRC_FILE_NAME,
COALESCE(h.DWH_SRC_1_TMSP,current_timestamp) DWH_SRC_TMSP,
COALESCE(h.DWH_SRC_1_TMSP,current_timestamp)  DWH_MAPPING_TMSP,
0 TF_ERROR_FG ,
0 DELETED_FG    ,
0 RECORD_ID ,
1 AS DWH_VALID_FG,
COALESCE(h.DWH_SRC_FILE_NAME,'na') AS FILENAME
FROM 
etl.T_CACHE_CDS_header_2 h
LEFT JOIN 
(SELECT 
 DISTINCT 
 entry_identifier, 
 case when substring(clearance_date,3,1)='/' then to_date(substring(clearance_date,1,10),'DD/MM_2/YYYY') else 
 to_date(substring(clearance_date,1,10),'YYYY-MM_2-DD')end clearance_date, 
 case when country_of_dispatch='NULL' then null else country_of_dispatch end country_of_dispatch, 
 case when location_of_goods='NULL' then null else location_of_goods end location_of_goods, 
 case when consignor ='NULL' then null else consignor end consignor,
 case when Deferment_2='NULL' then null else Deferment_2 end Deferment_2
 from etl.T_CACHE_CDS_item_2) i
on h.entry_identifier = i.entry_identifier
and case when substring(h.clearance_date,3,1)='/' then to_date(substring(h.clearance_date,1,10),'DD/MM_2/YYYY') else 
 to_date(substring(h.clearance_date,1,10),'YYYY-MM_2-DD')end = i.clearance_date  
cross JOIN 
(SELECT * FROM meta.T_LOCATION_KEY_2  
WHERE LOCATION_KEY_TYPE_CD = 'COUNTRY_2'
AND location_nat_key_nr = 'GB') gb_loc
LEFT JOIN meta.t_party_key_2 p1
ON p1.PARTY_KEY_TYPE_CD ='CONSIGNOR'
AND p1.PARTY_NAT_KEY_NR = NULLIF(upper(i.consignor),'NULL')
left join core_rel.t_consignor_2 con
on p1.party_sid = con.party_sid
LEFT JOIN meta.t_party_key_2 p4
ON p4.PARTY_KEY_TYPE_CD ='IMPORTER'
AND p4.PARTY_NAT_KEY_NR = NULLIF(h.IMPORTER_EORI ,'NULL')
LEFT JOIN meta.t_party_key_2 p2
ON p2.PARTY_KEY_TYPE_CD ='IMPORTER'
AND p2.PARTY_NAT_KEY_NR = NULLIF(h.declarant_EORI ,'NULL')
LEFT JOIN meta.t_party_key_2 p3
ON p3.PARTY_KEY_TYPE_CD ='BROKER'
AND p3.PARTY_NAT_KEY_NR = NULLIF(h.declarant_EORI ,'NULL')
LEFT JOIN meta.t_location_key_2 l1
ON l1.LOCATION_KEY_TYPE_CD  ='COUNTRY_2'
AND L1.LOCATION_NAT_KEY_NR = I.COUNTRY_OF_DISPATCH 
LEFT JOIN meta.t_location_key_2 l2
ON l2.LOCATION_KEY_TYPE_CD  ='TRANSHIPMENT'
AND L2.LOCATION_NAT_KEY_NR = 'GB|' || I.LOCATION_OF_GOODS
LEFT JOIN 
core_rel.t_transport_type_2 TT 
ON TT.foreigntrade_id = H.TRANSPORT_MODE 
LEFT JOIN meta.T_LOCATION_KEY_2 LC 
ON lc.LOCATION_KEY_TYPE_CD ='COUNTRY_2'
AND lc.LOCATION_NAT_KEY_NR = h.TRANSPORT_COUNTRY 
LEFT JOIN
meta.t_party_key_2 PK 
ON pk.PARTY_NAT_KEY_NR = UPPER(TRIM(i.CONSIGNOR))
AND pk.PARTY_KEY_TYPE_CD ='CONSIGNOR'
left
  join(select distinct
              movement_ref_number,
              trader_reference
         from core_rel.t_broker_report_2
      ) br
    on h.entry_identifier = br.movement_ref_number
   and NULLIF(h.declarant_reference,'NULL') is null
where
h.declaration_category IN ('IMA', 'IMD', 'IMY') and coalesce(NULLIF(h.declarant_reference,'NULL'), NULLIF(br.trader_reference,'NULL')) is not null
;
