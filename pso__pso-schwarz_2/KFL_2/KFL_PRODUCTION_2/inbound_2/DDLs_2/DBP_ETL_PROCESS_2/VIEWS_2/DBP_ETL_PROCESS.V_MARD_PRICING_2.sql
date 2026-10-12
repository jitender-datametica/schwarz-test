create or replace view DBP_ETL_PROCESS.V_MARD_PRICING_2(
	MANDANT_ID,
	DAT,
	WUP_ID,
	NB_ID,
	ART_ID,
	MENGE_LGBEST_ERP_FREI_BME,
	MENGE_LGBEST_ERP_QUAL_BME,
	MENGE_LGBEST_ERP_GESP_BME
) as (
select a.mandant_id,
       a.dat,
       a.wup_id,
       a.nb_id,
       a.art_id,
       a.menge_lgbest_erp_frei_bme,
       a.menge_lgbest_erp_qual_bme,
       a.menge_lgbest_erp_gesp_bme
from dbp_data.marktbestand_erp_2 a
join dbp_data.art_wg_zu_per_2 b
  on a.mandant_id = b.mandant_id and
     a.art_id = b.art_id and
     b.arthiertyp_id = 2 and
     b.dat_bis = '9999-12-31'
join dbp_data.wg_spr_zu_2 c
  on a.mandant_id = c.mandant_id and
     b.wg_id = c.wg_id and
     b.arthiertyp_id = c.arthiertyp_id and
     c.spr_id = 22
join dbp_data.wg_per_2 d
  on a.mandant_id = d.mandant_id and
     b.wg_id = d.wg_id and
     b.arthiertyp_id = d.arthiertyp_id and
     d.dat_bis = '9999-12-31'
join dbp_data.wup_2 e
  on a.mandant_id = e.mandant_id and
     a.wup_id = e.wup_id and
     e.nb_id = 0
where d.owg_id in (1006) and
      a.mandant_id = 1 and
      a.nb_id = 0
);