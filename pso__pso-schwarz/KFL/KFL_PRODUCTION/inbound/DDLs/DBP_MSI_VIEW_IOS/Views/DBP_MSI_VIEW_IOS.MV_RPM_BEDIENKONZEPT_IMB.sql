CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_RPM_BEDIENKONZEPT_IMB
AS
   --20171011 hmue2308: AP0004983, SPEC0029461 Anpassung neue Berichte
   --Bedienkonzept + Datum von Element und Immobilie als Attribut zur Anzeige*/*/
   --20171108 hmue2308: Attribute kategorisiert in imb und emt
   --20171218 msar Trennung mv_rpm_bedienkonzept in 2 Views (Immobilie, Element)
   --20180322 nfis: Internationalisierung - Auskommentieren der auspr_bez


   SELECT
   imb.techn_platz_id AS rpm_techn_platz_id,
   NULL AS rpm_projekt_id,
   ma.mandant_kbez,
   ma.mandant_id,
   /*MIN(
   CASE WHEN bedienkonzept_bez = 'ZPPM_BEDINS'
   THEN ai.bedienkonzept_auspr_bez
   END) AS imb_bedien_insel,*/
   MAX(
   CASE WHEN bedienkonzept_bez = 'ZPPM_BEDINS'
   THEN imb_dat_bedienkonzept
   ELSE NULL
   END ) AS imb_bedien_insel_dat,
   /*MIN(
   CASE WHEN bedienkonzept_bez = 'ZPPM_BOCKW'
   THEN ai.bedienkonzept_auspr_bez
   END) AS imb_bed_konzept_bockw,*/
   MAX(
   CASE WHEN bedienkonzept_bez = 'ZPPM_BOCKW'
   THEN imb_dat_bedienkonzept
   ELSE NULL
   END ) AS imb_bed_konzept_bockw_dat,
   /*MIN(
   CASE WHEN bedienkonzept_bez = 'ZPPM_BULK'
   THEN ai.bedienkonzept_auspr_bez
   END) AS imb_bed_konzept_bulk_food,*/
   MAX(
   CASE WHEN bedienkonzept_bez = 'ZPPM_BULK'
   THEN imb_dat_bedienkonzept
   ELSE NULL
   END ) AS imb_bed_konzept_bulk_food_dat,
   /*MIN(
   CASE WHEN bedienkonzept_bez = 'ZPPM_DISCOUNT'
   THEN ai.bedienkonzept_auspr_bez
   END) AS imb_discount_backshop,*/
   MAX(
   CASE WHEN bedienkonzept_bez = 'ZPPM_DISCOUNT'
   THEN imb_dat_bedienkonzept
   ELSE NULL
   END ) AS imb_discount_backshop_dat,
   /*MIN(
   CASE WHEN bedienkonzept_bez = 'ZPPM_FEINK'
   THEN ai.bedienkonzept_auspr_bez
   END) AS imb_bed_konzept_feinkost,*/
   MAX(
   CASE WHEN bedienkonzept_bez = 'ZPPM_FEINK'
   THEN imb_dat_bedienkonzept
   ELSE NULL
   END ) AS imb_bed_konzept_feinkost_dat,
   /*MIN(
   CASE WHEN bedienkonzept_bez = 'ZPPM_FISCH'
   THEN ai.bedienkonzept_auspr_bez
   END) AS imb_bed_konzept_fisch,*/
   MAX(
   CASE WHEN bedienkonzept_bez = 'ZPPM_FISCH'
   THEN imb_dat_bedienkonzept
   ELSE NULL
   END ) AS imb_bed_konzept_fisch_dat,
   /*MIN(
   CASE WHEN bedienkonzept_bez = 'ZPPM_FLEISCH'
   THEN ai.bedienkonzept_auspr_bez
   END) AS imb_bed_konzept_fleisch,*/
   MAX(
   CASE WHEN bedienkonzept_bez = 'ZPPM_FLEISCH'
   THEN imb_dat_bedienkonzept
   ELSE NULL
   END ) AS imb_bed_konzept_fleisch_dat,
   /*MIN(
   CASE WHEN bedienkonzept_bez = 'ZPPM_FRISCHB'
   THEN ai.bedienkonzept_auspr_bez
   END) AS imb_frische_baecker,*/
   MAX(
   CASE WHEN bedienkonzept_bez = 'ZPPM_FRISCHB'
   THEN imb_dat_bedienkonzept
   ELSE NULL
   END ) AS imb_frische_baecker_dat,
   /*MIN(
   CASE WHEN bedienkonzept_bez = 'ZPPM_GEFL'
   THEN ai.bedienkonzept_auspr_bez
   END) AS imb_bed_konzept_gefluegel,*/
   MAX(
   CASE WHEN bedienkonzept_bez = 'ZPPM_GEFL'
   THEN imb_dat_bedienkonzept
   ELSE NULL
   END ) AS imb_bed_konzept_gefluegel_dat,
   /*MIN(
   CASE WHEN bedienkonzept_bez = 'ZPPM_IMBISS'
   THEN ai.bedienkonzept_auspr_bez
   END) AS imb_imbiss,*/
   MAX(
   CASE WHEN bedienkonzept_bez = 'ZPPM_IMBISS'
   THEN imb_dat_bedienkonzept
   ELSE NULL
   END ) AS imb_imbiss_dat,
   /*MIN(
   CASE WHEN bedienkonzept_bez = 'ZPPM_KAESE'
   THEN ai.bedienkonzept_auspr_bez
   END) AS imb_bed_konzept_kaese,*/
   MAX(
   CASE WHEN bedienkonzept_bez = 'ZPPM_KAESE'
   THEN imb_dat_bedienkonzept
   ELSE NULL
   END ) AS imb_bed_konzept_kaese_dat,
   /*MIN(
   CASE WHEN bedienkonzept_bez = 'ZPPM_LEERGUT'
   THEN ai.bedienkonzept_auspr_bez
   END) AS imb_bed_konzept_leergut,*/
   MAX(
   CASE WHEN bedienkonzept_bez = 'ZPPM_LEERGUT'
   THEN imb_dat_bedienkonzept
   ELSE NULL
   END ) AS imb_bed_konzept_leergut_dat,
   /*MIN(
   CASE WHEN bedienkonzept_bez = 'ZPPM_WURST'
   THEN ai.bedienkonzept_auspr_bez
   END) AS imb_bed_konzept_wurst,*/
   MAX(
   CASE WHEN bedienkonzept_bez = 'ZPPM_WURST'
   THEN imb_dat_bedienkonzept
   ELSE NULL
   END ) AS imb_bed_konzept_wurst_dat

   FROM
   (
   SELECT techn_platz_id, NULL AS projekt_id, dat_bedienkonzept AS imb_dat_bedienkonzept,
   bedienkonzept_id AS imb_bedienkonzept_id, bedienkonzept_auspr_id AS imb_bedienkonzept_auspr_id
   FROM dbp_view.v_rpm_immobilie_per i
   INNER JOIN dbp_view.v_rpm_hier_bed_konzept_zu_per b
   ON i.rpm_hierarchie_id = b.rpm_hierarchie_id

   --IMMOBILIE
   WHERE b.rpm_tab_id = 2
   AND b.dat_bis='9999-12-31'
   AND i.dat_bis='9999-12-31'
   AND dat_bedienkonzept < CURRENT_DATE
   ) AS imb
   INNER JOIN dbp_view.v_l_bedienkonzept l
   ON imb_bedienkonzept_id = l.bedienkonzept_id
   LEFT JOIN dbp_view.v_mandant ma
   ON LEFT(imb.techn_platz_id,2) = DECODE(TRIM(ma.mandant_kbez),'D','DE',TRIM(ma.mandant_kbez)) --COALESCE(rpm_techn_platz_id,)*/

   INNER JOIN dbp_view.v_bedienkonzept_auspr_spr_zu ai
   ON imb_bedienkonzept_id = ai.bedienkonzept_id
   AND imb_bedienkonzept_auspr_id = ai.bedienkonzept_auspr_id
   AND ai.spr_id = 22

   --WHERE imb.techn_platz_id = 'DE-0001'
   GROUP BY
   rpm_techn_platz_id, rpm_projekt_id, ma.mandant_kbez,ma.mandant_id;