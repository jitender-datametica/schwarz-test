create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_SHR.MV_KOSTENSTELLE_HIERARCHIE_2(
	AKTMONATJAHR,
	MANDANT_ID,
	KRK_ID,
	KJMO,
	KST_ALTER,
	KOSTENSTELLE_EBENE1_ID,
	KOSTENSTELLE_EBENE2_ID,
	KOSTENSTELLE_EBENE3_ID,
	KOSTENSTELLE_EBENE4_ID,
	KOSTENSTELLE_EBENE5_ID,
	KOSTENSTELLE_EBENE6_ID,
	KOSTENSTELLE_EBENE7_ID,
	KOSTENSTELLE_EBENE8_ID,
	KOSTENSTELLE_EBENE9_ID,
	KOSTENSTELLE_EBENE10_ID,
	KOSTENSTELLE_EBENE11_ID,
	KOSTENSTELLE_EBENE12_ID,
	KOSTENSTELLE_EBENE13_ID,
	KOSTENSTELLE_EBENE14_ID,
	KOSTENSTELLE_EBENE15_ID,
	KOSTENSTELLE_EBENE1_BEZ,
	KOSTENSTELLE_EBENE2_BEZ,
	KOSTENSTELLE_EBENE3_BEZ,
	KOSTENSTELLE_EBENE4_BEZ,
	KOSTENSTELLE_EBENE5_BEZ,
	KOSTENSTELLE_EBENE6_BEZ,
	KOSTENSTELLE_EBENE7_BEZ,
	KOSTENSTELLE_EBENE8_BEZ,
	KOSTENSTELLE_EBENE9_BEZ,
	KOSTENSTELLE_EBENE10_BEZ,
	KOSTENSTELLE_EBENE11_BEZ,
	KOSTENSTELLE_EBENE12_BEZ,
	KOSTENSTELLE_EBENE13_BEZ,
	KOSTENSTELLE_EBENE14_BEZ,
	KOSTENSTELLE_EBENE15_BEZ
) as
-- 20221602 richternic - Hinzufuegen Kostenstellenalter 
WITH kst_ab AS( 
SELECT  kst.mandant_id, 
        kst.krk_id,
        kst.kostenstelle_ebene1_id,
        kst.kostenstelle_ebene15_id,
        MIN(KJMO) AS ab_kjmo
  FROM dbp_view.v_kostenstelle_hierarchie_2 kst
  WHERE kst.kostenstelle_ebene1_id IN ('KBG01','KDE01', 'KCZ01', 'KHR01', 'KPL01', 'KRO01','KSK01','KMD01')
  GROUP BY kst.mandant_id, 
        kst.krk_id,
        kst.kostenstelle_ebene1_id,
        kst.kostenstelle_ebene15_id
)
   SELECT

   (SELECT MAX(kjmo) FROM dbp_view.v_kostenstelle_hierarchie_2) AS aktMonatJahr, 
   v0.mandant_id, 
   v0.krk_id, 
   v1.kjmo, 
    ---
    CASE 
      -- FALL 1 Monat_2 vor dem ab --> dies passiert durch den CROSS JOIN dass alle Monate dazugefuegt werden
      WHEN v1.kjmo < kst_ab.ab_kjmo
      THEN 0
       -- FALL 1 gleiches Jahr dann alles gut 
      WHEN TRUNC (v1.kjmo/100) =  TRUNC(kst_ab.ab_kjmo/100)
      THEN v1.kjmo - kst_ab.ab_kjmo +1
      -- FALL 2 unter 12 Monate -> anderes Jahr
      WHEN TRUNC (v1.kjmo/100) = TRUNC(kst_ab.ab_kjmo/100)+1 AND v1.kjmo < kst_ab.ab_kjmo+100
      THEN  ROUND(12 - (kst_ab.ab_kjmo - (TRUNC(kst_ab.ab_kjmo/100) * 100) ) + RIGHT(v1.kjmo, 2)) +1  
      ELSE 12 END AS alter_kst,
   v0.kostenstelle_ebene1_id, 
   v0.kostenstelle_ebene2_id, 
   v0.kostenstelle_ebene3_id, 
   v0.kostenstelle_ebene4_id, 
   v0.kostenstelle_ebene5_id, 
   v0.kostenstelle_ebene6_id, 
   v0.kostenstelle_ebene7_id, 
   v0.kostenstelle_ebene8_id, 
   v0.kostenstelle_ebene9_id, 
   v0.kostenstelle_ebene10_id, 
   v0.kostenstelle_ebene11_id, 
   v0.kostenstelle_ebene12_id, 
   v0.kostenstelle_ebene13_id, 
   v0.kostenstelle_ebene14_id, 
   v0.kostenstelle_ebene15_id, 
   v0.kostenstelle_ebene1_bez, 
   v0.kostenstelle_ebene2_bez, 
   v0.kostenstelle_ebene3_bez, 
   v0.kostenstelle_ebene4_bez, 
   v0.kostenstelle_ebene5_bez, 
   v0.kostenstelle_ebene6_bez, 
   v0.kostenstelle_ebene7_bez, 
   v0.kostenstelle_ebene8_bez, 
   v0.kostenstelle_ebene9_bez, 
   v0.kostenstelle_ebene10_bez, 
   v0.kostenstelle_ebene11_bez, 
   v0.kostenstelle_ebene12_bez, 
   v0.kostenstelle_ebene13_bez, 
   v0.kostenstelle_ebene14_bez, 
   v0.kostenstelle_ebene15_bez

   FROM dbp_view.v_kostenstelle_hierarchie_2 v0
   INNER JOIN kst_ab
   ON kst_ab.mandant_id = v0.mandant_id AND
        kst_ab.krk_id = v0.krk_id AND
        kst_ab.kostenstelle_ebene1_id = v0.kostenstelle_ebene1_id AND 
        kst_ab.kostenstelle_ebene15_id = v0.kostenstelle_ebene15_id
   CROSS JOIN (SELECT DISTINCT kjmo FROM dbp_view.v_kostenstelle_hierarchie_2) AS v1 
   WHERE v0.kostenstelle_ebene1_id IN ('KBG01','KDE01', 'KCZ01', 'KHR01', 'KPL01', 'KRO01','KSK01','KMD01') 
   AND  v0.kjmo = aktMonatJahr;
