CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_RPM_BEDIENKONZEPT_2
AS
   --20171011 hmue2308: AP0004983, SPEC0029461 Anpassung neue Berichte
   --Bedienkonzept + Datum von Element und Immobilie als Attribut zur Anzeige*/*/
   --20171108 hmue2308: Attribute kategorisiert in imb und emt
   --20171218 msar Trennung mv_rpm_bedienkonzept_2 in 2 Views (Immobilie, Element)
   -- 20180322 nfis0811: Internationalisierung - Auskommentieren auspr_bez


   SELECT
   emt.techn_platz_id AS rpm_techn_platz_id,
   emt.projekt_id AS rpm_projekt_id,
   ma.mandant_kbez,
   ma.mandant_id,
   /*MIN(
   CASE WHEN bedienkonzept_bez = 'ZPPM_BEDINS'
   THEN a.bedienkonzept_auspr_bez
   END) AS emt_bedien_insel,*/
   MAX(
   CASE WHEN bedienkonzept_bez = 'ZPPM_BEDINS'
   THEN emt_dat_bedienkonzept
   ELSE NULL
   END ) AS emt_bedien_insel_dat,
   /*MIN(
   CASE WHEN bedienkonzept_bez = 'ZPPM_BOCKW'
   THEN a.bedienkonzept_auspr_bez
   END) AS emt_bed_konzept_bockw,*/
   MAX(
   CASE WHEN bedienkonzept_bez = 'ZPPM_BOCKW'
   THEN emt_dat_bedienkonzept
   ELSE NULL
   END ) AS emt_bed_konzept_bockw_dat,
   /*MIN(
   CASE WHEN bedienkonzept_bez = 'ZPPM_BULK'
   THEN a.bedienkonzept_auspr_bez
   END) AS emt_bed_konzept_bulk_food,*/
   MAX(
   CASE WHEN bedienkonzept_bez = 'ZPPM_BULK'
   THEN emt_dat_bedienkonzept
   ELSE NULL
   END ) AS emt_bed_konzept_bulk_food_dat,
   /*MIN(
   CASE WHEN bedienkonzept_bez = 'ZPPM_DISCOUNT'
   THEN a.bedienkonzept_auspr_bez
   END) AS emt_discount_backshop,*/
   MAX(
   CASE WHEN bedienkonzept_bez = 'ZPPM_DISCOUNT'
   THEN emt_dat_bedienkonzept
   ELSE NULL
   END ) AS emt_discount_backshop_dat,
   /*MIN(
   CASE WHEN bedienkonzept_bez = 'ZPPM_FEINK'
   THEN a.bedienkonzept_auspr_bez
   END) AS emt_bed_konzept_feinkost,*/
   MAX(
   CASE WHEN bedienkonzept_bez = 'ZPPM_FEINK'
   THEN emt_dat_bedienkonzept
   ELSE NULL
   END ) AS emt_bed_konzept_feinkost_dat,
   /*MIN(
   CASE WHEN bedienkonzept_bez = 'ZPPM_FISCH'
   THEN a.bedienkonzept_auspr_bez
   END) AS emt_bed_konzept_fisch,*/
   MAX(
   CASE WHEN bedienkonzept_bez = 'ZPPM_FISCH'
   THEN emt_dat_bedienkonzept
   ELSE NULL
   END ) AS emt_bed_konzept_fisch_dat,
   /*MIN(
   CASE WHEN bedienkonzept_bez = 'ZPPM_FLEISCH'
   THEN a.bedienkonzept_auspr_bez
   END) AS emt_bed_konzept_fleisch,*/
   MAX(
   CASE WHEN bedienkonzept_bez = 'ZPPM_FLEISCH'
   THEN emt_dat_bedienkonzept
   ELSE NULL
   END ) AS emt_bed_konzept_fleisch_dat,
   /*MIN(
   CASE WHEN bedienkonzept_bez = 'ZPPM_FRISCHB'
   THEN a.bedienkonzept_auspr_bez
   END) AS emt_frische_baecker,*/
   MAX(
   CASE WHEN bedienkonzept_bez = 'ZPPM_FRISCHB'
   THEN emt_dat_bedienkonzept
   ELSE NULL
   END ) AS emt_frische_baecker_dat,
   /*MIN(
   CASE WHEN bedienkonzept_bez = 'ZPPM_GEFL'
   THEN a.bedienkonzept_auspr_bez
   END) AS emt_bed_konzept_gefluegel,*/
   MAX(
   CASE WHEN bedienkonzept_bez = 'ZPPM_GEFL'
   THEN emt_dat_bedienkonzept
   ELSE NULL
   END ) AS emt_bed_konzept_gefluegel_dat,
   /*MIN(
   CASE WHEN bedienkonzept_bez = 'ZPPM_IMBISS'
   THEN a.bedienkonzept_auspr_bez
   END) AS emt_imbiss,*/
   MAX(
   CASE WHEN bedienkonzept_bez = 'ZPPM_IMBISS'
   THEN emt_dat_bedienkonzept
   ELSE NULL
   END ) AS emt_imbiss_dat,
   /*MIN(
   CASE WHEN bedienkonzept_bez = 'ZPPM_KAESE'
   THEN a.bedienkonzept_auspr_bez
   END) AS emt_bed_konzept_kaese,*/
   MAX(
   CASE WHEN bedienkonzept_bez = 'ZPPM_KAESE'
   THEN emt_dat_bedienkonzept
   ELSE NULL
   END ) AS emt_bed_konzept_kaese_dat,
   /*MIN(
   CASE WHEN bedienkonzept_bez = 'ZPPM_LEERGUT'
   THEN a.bedienkonzept_auspr_bez
   END) AS emt_bed_konzept_leergut,*/
   MAX(
   CASE WHEN bedienkonzept_bez = 'ZPPM_LEERGUT'
   THEN emt_dat_bedienkonzept
   ELSE NULL
   END ) AS emt_bed_konzept_leergut_dat,
   /*MIN(
   CASE WHEN bedienkonzept_bez = 'ZPPM_WURST'
   THEN a.bedienkonzept_auspr_bez
   END) AS emt_bed_konzept_wurst,*/
   MAX(
   CASE WHEN bedienkonzept_bez = 'ZPPM_WURST'
   THEN emt_dat_bedienkonzept
   ELSE NULL
   END ) AS emt_bed_konzept_wurst_dat

   FROM
   (
   SELECT DISTINCT techn_platz_id, projekt_id, dat_bedienkonzept AS emt_dat_bedienkonzept,
   bedienkonzept_id AS emt_bedienkonzept_id, bedienkonzept_auspr_id AS emt_bedienkonzept_auspr_id
   FROM dbp_view.v_rpm_immobilie_per_2 ri
   INNER JOIN dbp_view.v_rpm_element_per_2 i
   ON ri.rpm_hierarchie_id =i.rpm_immobilie_id
   AND  i.rpm_status_id NOT IN (1,4,5,6)
   INNER JOIN dbp_view.v_rpm_phase_spr_zu_2 rp
   ON rp.rpm_phase_id = i.rpm_phase_id
   AND rp.rpm_projekt_typ_id = i.rpm_projekt_typ_id
   AND rp.spr_id = 22
   INNER JOIN dbp_view.v_rpm_hier_bed_konzept_zu_per_2 b
   ON i.rpm_hierarchie_id = b.rpm_hierarchie_id
   WHERE  b.rpm_tab_id = 3
   AND  b.dat_bis='9999-12-31'
   AND i.dat_bis='9999-12-31'
   AND (dat_bedienkonzept  >= CURRENT_DATE
   OR dat_bedienkonzept  = '101' )
   AND ri.dat_bis='9999-12-31'
   ) AS emt
   INNER JOIN dbp_view.v_l_bedienkonzept_2 l
   ON emt_bedienkonzept_id = l.bedienkonzept_id
   LEFT JOIN dbp_view.v_mandant_2 ma
   ON LEFT(emt.techn_platz_id,2) = DECODE(TRIM(ma.mandant_kbez),'D','DE',TRIM(ma.mandant_kbez)) --COALESCE(rpm_techn_platz_id,)*/

   INNER JOIN dbp_view.v_bedienkonzept_auspr_spr_zu_2 a
   ON emt_bedienkonzept_id = a.bedienkonzept_id
   AND emt_bedienkonzept_auspr_id = a.bedienkonzept_auspr_id
   AND a.spr_id = 22

   --WHERE emt.techn_platz_id = 'DE-0001'
   GROUP BY
   rpm_techn_platz_id, rpm_projekt_id, ma.mandant_kbez,ma.mandant_id;