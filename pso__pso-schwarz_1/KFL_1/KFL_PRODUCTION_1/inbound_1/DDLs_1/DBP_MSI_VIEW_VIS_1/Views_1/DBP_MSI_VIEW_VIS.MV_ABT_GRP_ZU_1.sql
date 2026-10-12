CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ABT_GRP_ZU_1 as
   -- ZUORDNUNG : Abteilungsgruppe - Abteilung
   -- 2010KW07 : arthiertyp_1 2 für 3stellige WG

   -- KEINE EINSCHRAENKUNG

   SELECT
   v01.mandant_id, v01.arthiertyp_id, v01.abt_grp_id, v01.abt_id

   FROM dbp_view.v_abt_abt_grp_zu_1 v01

-- WHERE v01.arthiertyp_id = 2
;