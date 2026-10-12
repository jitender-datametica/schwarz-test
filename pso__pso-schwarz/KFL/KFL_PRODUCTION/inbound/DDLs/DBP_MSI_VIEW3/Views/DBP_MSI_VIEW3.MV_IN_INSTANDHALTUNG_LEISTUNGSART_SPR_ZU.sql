CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_IN_INSTANDHALTUNG_LEISTUNGSART_SPR_ZU (
   mandant_id,
   instandhaltung_leistungsart_id,
   spr_id,
   instandhaltung_leistungsart_bez,
   instandhalt_leistart_bez_lang
) AS
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.mandant_id,
   v01.instandhaltung_leistungsart_id,
   v01.spr_id,
   v01.instandhaltung_leistungsart_bez,
   TRIM(v01.instandhaltung_leistungsart_id) || ' ' || TRIM(v01.instandhaltung_leistungsart_bez) AS instandhalt_leistart_bez_lang
FROM
   dbp_view.v_in_instandhaltung_leistungsart_spr_zu v01
   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU v02 
   ON v01.spr_id = v02.spr_id;