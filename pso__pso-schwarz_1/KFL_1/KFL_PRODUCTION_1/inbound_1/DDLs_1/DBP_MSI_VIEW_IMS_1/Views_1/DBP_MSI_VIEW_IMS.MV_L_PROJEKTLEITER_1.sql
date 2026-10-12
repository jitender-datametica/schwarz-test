CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_L_PROJEKTLEITER_1
-- 09.04.2013 AL Init
-- 29.04.2021 twie: NSR2133664 Join auf l_ma_1 entfernt, da ma_ldap jetzt aus ma_spr_zu_1 kommt

AS
   SELECT v01.ma_id AS it_pl_id,
   v01.ma_vorname || ' ' || v01.ma_name AS ma_name,
   v01.ma_ldap

   FROM dbp_view.v_ma_spr_zu_1  v01
 
   WHERE v01.mandant_id=1 
   AND   spr_id=22
   AND
   (v01. ma_id) IN (SELECT
   ma_id
   FROM dbp_view.v_it_projekt_ma_zu_1 v01
   WHERE v01.mandant_id=1 AND     ma_funktion_id='CLPL'
   )
;