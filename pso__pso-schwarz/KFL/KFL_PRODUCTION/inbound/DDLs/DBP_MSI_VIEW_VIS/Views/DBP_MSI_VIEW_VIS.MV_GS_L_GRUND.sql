CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_GS_L_GRUND as
   -- LOOKUP/ZUORDNUNG Geschenk-Karten Grund [ausgeber/ausgeber_typ]
   -- 2011KW46 Initial

   SELECT
   v01.mandant_id, v01.ausgeber_typ_id  --> Bereich
   , v01.ausgeber_id    --> Grund
   FROM dbp_view.v_l_ausgeber  v01

   UNION ALL
   SELECT
   v01.mandant_id, v01.ausgeber_typ_id  --> Bereich
   , '0'::VARCHAR(10) AS ausgeber_id    --> Grund
   FROM dbp_view.v_ausgeber_typ_spr_zu v01
   WHERE v01.mandant_id = 1;