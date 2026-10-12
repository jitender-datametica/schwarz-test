CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_MARKT_BESTAND_ERP_2
-- AL 31.05.2011 erstellt analog AIS_DE. Aktuell existieren nur die Daten fuer DE
-- 25102022 snik1809: updated join with v_marktbestand_erp_zu_2 by adding mandant_id
(
mandant_id
, wup_id
, nb_id
, art_id
, stimmig_id
, dat
, wrg_id
, ds_markt_bestand_menge_frei
, ds_markt_bestand_menge_qual
, ds_markt_bestand_menge_ges
, ds_markt_bestand_ekn_frei
, ds_markt_bestand_ekn_qual
, ds_markt_bestand_ekn_ges
, ds_markt_bestand_ekn_bnk_frei
, ds_markt_bestand_ekn_bnk_qual
, ds_markt_bestand_ekn_bnk_ges
, ds_markt_bestand_vkn_frei
, ds_markt_bestand_vkn_qual
, ds_markt_bestand_vkn_ges
)
AS
   SELECT
   v01.mandant_id, v01.wup_id, v01.nb_id, v01.art_id, v01.relevant_fg AS stimmig_id, v01.dat, v02.wrg_id, v01.menge_lgbest_erp_frei_bme AS ds_markt_bestand_menge_frei, v01.menge_lgbest_erp_qual_bme AS ds_markt_bestand_menge_qual, CAST(v01.menge_lgbest_erp_frei_bme + v01.menge_lgbest_erp_qual_bme AS NUMBER(38,5)) AS ds_markt_bestand_menge_ges, CAST(ds_markt_bestand_menge_frei * v02.ek_netto AS NUMBER(38,5)) AS ds_markt_bestand_ekn_frei, CAST(ds_markt_bestand_menge_qual * v02.ek_netto AS NUMBER(38,5)) AS ds_markt_bestand_ekn_qual, CAST(ds_markt_bestand_menge_ges * v02.ek_netto AS NUMBER(38,5)) AS ds_markt_bestand_ekn_ges, CAST(ds_markt_bestand_menge_frei * v02.ek_netto_bnk AS NUMBER(38,5)) AS ds_markt_bestand_ekn_bnk_frei, CAST(ds_markt_bestand_menge_qual * v02.ek_netto_bnk AS NUMBER(38,5)) AS ds_markt_bestand_ekn_bnk_qual, CAST(ds_markt_bestand_menge_ges * v02.ek_netto_bnk AS NUMBER(38,5)) AS ds_markt_bestand_ekn_bnk_ges, CAST(ds_markt_bestand_menge_frei * v02.vk_netto AS NUMBER(38,5)) AS ds_markt_bestand_vkn_frei, CAST(ds_markt_bestand_menge_qual * v02.vk_netto AS NUMBER(38,5)) AS ds_markt_bestand_vkn_qual, CAST(ds_markt_bestand_menge_ges * v02.vk_netto AS NUMBER(38,5)) AS ds_markt_bestand_vkn_ges

   FROM dbp_view.v_marktbestand_erp_2 v01

   JOIN dbp_view.v_marktbestand_erp_zu_2 v02
   ON v01.bestand_id = v02.bestand_id
   AND v01.mandant_id = v02.mandant_id

   WHERE v01.mandant_id =1;