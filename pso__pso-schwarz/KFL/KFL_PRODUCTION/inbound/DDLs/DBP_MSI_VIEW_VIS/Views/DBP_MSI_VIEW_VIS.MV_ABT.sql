CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ABT as
   -- LOOKUP : Abteilung
   -- 2010KW07 : arthiertyp 2  für 3stellige WG
   -- 20120325 : Neue Abteilungsstruktur / Sortierung
   -- 20120326 : Fehlerkorrektur


   SELECT
   v01.mandant_id, v01.arthiertyp_id, v01.abt_id, CASE
   WHEN v01.abt_id <=0  THEN v01.abt_id + 1000
   ELSE v01.abt_id
   END  AS sort_id

   FROM dbp_view.v_abt v01

   WHERE v01.arthiertyp_id = 2;