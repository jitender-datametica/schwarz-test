CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_IN_AUFTRAGSART_SPR_ZU_SK AS
-- 10.06.2013 AL init
-- 27.06.2013 twie: wenn keine Landessprache (ls) vorhanden ist, de ausgeben
-- 20.08.2013/Gia

   SELECT
   de.auftragsart_id,
   COALESCE(ls.auftragsart_bez, de.auftragsart_bez) AS auftragsart_bez

   FROM dbp_view.v_in_auftragsart_spr_zu   de
   LEFT OUTER JOIN
   (
   SELECT *
   FROM dbp_view.v_in_auftragsart_spr_zu
   WHERE spr_id = 108
   QUALIFY RANK() OVER (PARTITION BY auftragsart_id ORDER BY mandant_id) =1
   ) ls
   ON de.auftragsart_id = ls.auftragsart_id

   WHERE de.spr_id = 22
   QUALIFY RANK() OVER (PARTITION BY de.auftragsart_id ORDER BY de.mandant_id) =1
   ;