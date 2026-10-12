delete from dbp_etl_process.art_nielsen_gtin_zu_1;

create or replace volatile table _art_nielsen_multi_gtin
as
(
select * from dbp_data.art_nielsen_1 where gtin_ref_id is not null and gtin_ref_id like '%,%' and dat_bis='9999-12-31'
) ;

create or replace volatile table _art_nielsen_norm
as
(
select 
distinct
mandant_id,art_nielsen_id,art_nielsen_tag,art_nielsen_bez,hersteller_bez,gtin_id,
inhalt_menge,inhalt_einheit,nielsen_abteilung_bez,nielsen_wg_bez,nielsen_uwg1_bez,nielsen_uwg2_bez,td_update,td_insert,marke_bez,bio_organic_kz,veggy_split_kz,laktosefrei_kz,glutenfrei_kz,duft_geschmack_bez,nielsen_vorschl_wg_id,nielsen_vorschl_wug_id,datzeit_letzte_eintragung_nielsen_vorschl,
c.value::string as gtin_ref_id
from _art_nielsen_multi_gtin,
lateral flatten(input=>split(gtin_ref_id, ',')) c
)
;

delete from _art_nielsen_norm
where try_to_decimal(gtin_ref_id) is null
;

insert into dbp_etl_process.art_nielsen_gtin_zu_1
(
mandant_id,art_nielsen_id,art_nielsen_tag,art_nielsen_bez,hersteller_bez,gtin_id,inhalt_menge,inhalt_einheit,nielsen_abteilung_bez,nielsen_wg_bez,nielsen_uwg1_bez,nielsen_uwg2_bez,gtin_ref_id,marke_bez,bio_organic_kz,veggy_split_kz,laktosefrei_kz,glutenfrei_kz,duft_geschmack_bez,nielsen_vorschl_wg_id,nielsen_vorschl_wug_id,datzeit_letzte_eintragung_nielsen_vorschl
)
select mandant_id,art_nielsen_id,art_nielsen_tag,art_nielsen_bez,hersteller_bez,gtin_id,inhalt_menge,inhalt_einheit,nielsen_abteilung_bez,nielsen_wg_bez,nielsen_uwg1_bez,nielsen_uwg2_bez,gtin_ref_id,marke_bez,bio_organic_kz,veggy_split_kz,laktosefrei_kz,glutenfrei_kz,duft_geschmack_bez,nielsen_vorschl_wg_id,nielsen_vorschl_wug_id,datzeit_letzte_eintragung_nielsen_vorschl
from _art_nielsen_norm where (mandant_id,art_nielsen_id,gtin_ref_id) not in (select mandant_id,art_nielsen_id,gtin_id from dbp_data.art_nielsen_1 where dat_bis='9999-12-31')
;
