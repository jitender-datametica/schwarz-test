CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_TECHN_PLATZ_SPR_ZU_RO AS
-- 13.06.2013 AL Init
-- 27.06.2013 twie: wenn keine Landessprache (ls) vorhanden ist, de ausgeben
-- 04.12.2014 twie: Korrektur tech_platz_bez -> techn_platz_bez

   SELECT
   v01.techn_platz_id,
   COALESCE(ls.tech_platz_bez, de.tech_platz_bez, '') AS techn_platz_bez

   FROM dbp_view.v_techn_platz_per   v01
   LEFT OUTER JOIN dbp_view.v_techn_platz_spr_zu_per de
   ON v01.techn_platz_id = de.techn_platz_id AND
   de.dat_bis='9999-12-31' AND
   de.spr_id=22
   LEFT OUTER JOIN dbp_view.v_techn_platz_spr_zu_per ls
   ON v01.techn_platz_id = ls.techn_platz_id AND
   ls.dat_bis='9999-12-31' AND
   ls.spr_id=95

   WHERE v01.dat_bis= '9999-12-31';