CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_ART_SPR_ZU_2
AS
   SELECT

   v01.art_id, v01.mandant_id, v01.art_bez

   FROM dbp_view.v_art_spr_zu_2 v01
   INNER JOIN dbp_view.v_art_wg_zu_per_2 v02
   ON  v01.art_id = v02.art_id
   AND  v01.mandant_id = v02.mandant_id

   JOIN dbp_msi.akt_msi_user_spr_zu_2 v03
   ON v01.spr_id = v03.spr_id

   WHERE v01.mandant_id IN (1,2)

   -- eindeutigen Datensatz aus art_wg_zu_per_2 ermitteln
   AND v02.dat_bis='9999-12-31'
   AND v02.arthiertyp_id = 2

   -- nur FLW Artikel_2
   -- Naku  Alte wg_id (1, 2, 3, 5, 9, 10, 12, 13, 19) durch neue laut Mapping Tabelle in SPEC0034878 ersetzt . Dh. 1, 2, 3, 5, 9, 10, 12, 13, 19 = 003,122,128,134,135,136,137,138,139,141,142,144,145,146,147,158,159,184,186,232,233,234,235,236,237,238,239,331,242,243,244,245,246
   AND v02.wg_id IN (003,122,128,134,135,136,137,138,139,141,142,144,145,146,147,158,159,184,186,232,233,234,235,236,237,238,239,331,242,243,244,245,246);