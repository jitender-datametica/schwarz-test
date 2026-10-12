CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_crm_f_ods_bon_kopf_kunde_tag_sum_1 (mandant_id, wup_id,
nb_id, kundenkarte_id, crm_kundenkarte_art_id, crm_konto_id, crm_konto_typ_id, dat, kjwo_ww, anz_bons) AS SELECT K.mandant_id
 ,
 K.wup_id,
 K.nb_id,
 K.kundenkarte_id,
 KAR.crm_kundenkarte_art_id,
 KON.crm_konto_id,
 KON.crm_konto_typ_id,
 K.dat,
 V03.kjwo_ww,
 SUM(K.anz_bons) AS anz_bons
FROM kfl_production_dbp_view.v_crm_kartebew_1 AS K
 INNER JOIN kfl_production_dbp_view.v_crm_l_kundenkarte_1 AS KAR ON K.kundenkarte_id = KAR.kundenkarte_id AND K.mandant_id
    = KAR.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_crm_l_konto_1 AS KON ON KAR.crm_konto_id = KON.crm_konto_id
 LEFT JOIN kfl_production_dbp_view.v_werbewoche_kl_1 AS V03 ON K.dat = V03.dat AND K.mandant_id = V03.mandant_id
GROUP BY K.mandant_id,
 K.wup_id,
 K.nb_id,
 K.kundenkarte_id,
 KAR.crm_kundenkarte_art_id,
 KON.crm_konto_id,
 KON.crm_konto_typ_id,
 K.dat,
 V03.kjwo_ww;