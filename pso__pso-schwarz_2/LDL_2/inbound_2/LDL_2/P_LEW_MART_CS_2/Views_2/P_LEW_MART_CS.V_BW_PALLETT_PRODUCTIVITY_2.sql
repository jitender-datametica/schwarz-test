/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BW_PALLETT_PRODUCTIVITY_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_BW_PALLETT_PRODUCTIVITY_2
(
 client_id
,iso_cd
,cy_month
,kpi_aspect
,wh_id
,paletten_warenausgang
,palettenleistung_lager
,nettostunden_gesamt
,paletten_wareneingang
,palettenleistung_lager_aufgel
,wb_nettokolli
,kilometer
,nettostd_mitarbeiter_int
,nettostd_mitarbeiter_ext
,nettostd_gesamt_wb_retoure
,kapazitaet
,paletten_warenausgang_up
 )
AS


   SELECT ind.client_id                                    AS client_id,
   cty.src_country_lidl_cd                         AS iso_cd,
   ind.cy_month                                    AS cy_month,
   CASE WHEN ind.org_type_id = 50
                 THEN 'BGES'
               ELSE 'Land_2'
          END                                              AS kpi_aspect,
   CASE WHEN ind.org_unit_nr = -1
                 THEN NULL
               ELSE ind.org_unit_nr
          END                                              AS wh_id,
   ind.paletten_warenausgang                       AS paletten_warenausgang,
   ind.palettenleistung_lager                      AS palettenleistung_lager,
   ind.nettostunden_gesamt                         AS nettostunden_gesamt,
   ind.paletten_wareneingang                       AS paletten_wareneingang,
   paletten_calc.palettenleistung_lager_aufgel     AS palettenleistung_lager_aufgel,
   ind.wb_nettokolli                               AS wb_nettokolli,
   ind.kilometer                                   AS kilometer,
   ind.nettostd_mitarbeiter_int                    AS nettostd_mitarbeiter_int,
   ind.nettostd_mitarbeiter_ext                    AS nettostd_mitarbeiter_ext,
   nettostd_gesamt_wb_retoure                      AS nettostd_gesamt_wb_retoure,
   ind.kapazitaet                                  AS kapazitaet,
   ind.paletten_warenausgang_up                        AS paletten_warenausgang_up
     FROM p_lew_mart_cs.v_bw_pallett_productivity_base_2 ind
   INNER JOIN p_lew_core_ac.v_country_2 cty
   ON ind.client_id = cty.country_sid
   LEFT OUTER JOIN p_lew_core_ac.v_location_2 loc
   ON ind.client_id = loc.client_id AND ind.org_unit_nr = loc.src_wh_id
   LEFT OUTER JOIN
   /*
   #----------------------------------------------------------------------------
   #Part 2 calculates the kpi for palettenleistung lager aufgel., which is calculated as paletten_warenausgang/nettostd_gesamt. It is compounding on a monthly basis, for each Lidl business year.
   #----------------------------------------------------------------------------
   */
   (
    SELECT cy_month             AS cy_month,
   client_id           AS client_id,
   org_unit_nr         AS org_unit_nr,
   org_type_id         AS org_type_id,
   CASE WHEN SUM(nettostunden_gesamt) OVER (PARTITION BY busyear_seq, client_id, org_unit_nr ORDER BY cy_month ROWS UNBOUNDED PRECEDING) <> 0
                    THEN SUM(paletten_warenausgang) OVER (PARTITION BY busyear_seq, client_id, org_unit_nr ORDER BY cy_month ROWS UNBOUNDED PRECEDING) / SUM(nettostunden_gesamt) OVER (PARTITION BY busyear_seq, client_id, org_unit_nr ORDER BY cy_month ROWS UNBOUNDED PRECEDING)
   ELSE 0
END                  AS palettenleistung_lager_aufgel
FROM p_lew_mart_cs.v_bw_pallett_productivity_base_2 ind
   ) AS paletten_calc
   ON ind.cy_month = paletten_calc.cy_month
   AND ind.client_id = paletten_calc.client_id
   AND ind.org_type_id = paletten_calc.org_type_id
   AND ind.org_unit_nr = paletten_calc.org_unit_nr
   ;