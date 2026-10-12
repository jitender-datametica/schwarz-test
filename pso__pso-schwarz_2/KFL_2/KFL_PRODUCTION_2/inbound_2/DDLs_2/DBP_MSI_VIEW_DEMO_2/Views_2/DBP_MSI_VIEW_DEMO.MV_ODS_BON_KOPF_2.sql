CREATE OR REPLACE VIEW DBP_MSI_VIEW_DEMO.MV_ODS_BON_KOPF_2
AS
SELECT

v01.bon_id,
v01.bon_dat,
v01.wup_id,
v01.mandant_id,
v01.bon_nr,
v01.kasse_nr,
v01.kunde_fg,
v01.bon_beginn,
v01.bon_ende,
v01.umsatz_mwst,
v01.umsatz_brutto,
v01.bon_booking,
v01.dat_booking,
v01.turnover_fg,
v01.wrg_id,
v01.kasse_typ_id,
v01.reactivated_fg,
v01.kpos_kasse_typ,
v01.wagen_nr,
v01.kundenkarte_id,
v01.kundenkarte_typ_id
FROM dbp_v_ods.v_ods_bon_kopf_2 v01

where v01.mandant_id = 7
and v01.kundenkarte_id is not null
;



