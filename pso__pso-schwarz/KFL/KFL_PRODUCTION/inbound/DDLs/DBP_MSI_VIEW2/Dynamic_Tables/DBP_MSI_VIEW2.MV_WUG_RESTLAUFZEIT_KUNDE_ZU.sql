CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_WUG_RESTLAUFZEIT_KUNDE_ZU
(
	MANDANT_ID,
	ART_ID,
	ARTHIERTYP_ID,
	WG_ID,
	WUG_ID,
	MAX_MHD_ZEITRAUM_AB,
	MAX_RESTLAUFZEIT_IST
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
t01.mandant_id, 
t01.art_id, 
t01.arthiertyp_id, 
t01.wg_id, 
t01.wug_id, 
MAX(t01.mhd_zeitraum_ab), 
MAX(t01.restlaufzeit_ist)
   FROM
   (
   
   SELECT 
   v01.mandant_id, 
   v01.art_id, 
   v02.arthiertyp_id, 
   v02.wg_id, 
   v02.wug_id, 
   v03.mhd_zeitraum_ab, 
   v03.restlaufzeit_ist
   FROM dbp_view.v_art v01
   INNER JOIN dbp_view.v_art_wg_zu_per v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.art_id = v02.art_id
   AND v02.dat_bis = '9999-12-31'
   INNER JOIN dbp_view.v_wug_restlaufzeit_kunde_zu v03 

   ON v02.mandant_id = v03.mandant_id
   AND v02.arthiertyp_id = v03.arthiertyp_id
   AND v02.wg_id = v03.wg_id
   AND v02.wug_id = v03.wug_id
   WHERE v01.mandant_id = 1
   AND v02.arthiertyp_id = 2
   AND v03.einstellung_schema = 'Z001'   
   AND v03.mhd_zeitraum_ab <= v01.mhd_zeitraum
   ) t01

   GROUP BY t01.mandant_id
   ,t01.art_id
   ,t01.arthiertyp_id
   ,t01.wg_id
   ,t01.wug_id

   UNION
  
   SELECT 
   t01.mandant_id, 
   t01.art_id, 
   t01.arthiertyp_id, 
   t01.wg_id, 
   t01.wug_id, 
   MAX(v04.mhd_zeitraum_ab) AS max_mhd_zeitraum_ab, 
   MAX(v04.restlaufzeit_ist) AS max_restlaufzeit_ist
   FROM
   ( 
   SELECT 
   v01.mandant_id, 
   v01.art_id, 
   v01.mhd_zeitraum, 
   v02.arthiertyp_id, 
   v02.wg_id, 
   v02.wug_id
   FROM dbp_view.v_art v01
   INNER JOIN dbp_view.v_art_wg_zu_per v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.art_id = v02.art_id
   AND v02.dat_bis = '9999-12-31'
   AND v02.arthiertyp_id = 2
   WHERE v01.mandant_id = 1
   AND (v01.mandant_id
   ,v02.arthiertyp_id
   ,v02.wg_id
   ,v02.wug_id) NOT IN (SELECT v03.mandant_id, v03.arthiertyp_id, v03.wg_id, v03.wug_id
   FROM dbp_view.v_wug_restlaufzeit_kunde_zu v03
   WHERE v03.arthiertyp_id = 2 
   AND v03.einstellung_schema = 'Z001'
   )
   ) t01
   LEFT JOIN dbp_view.v_wug_restlaufzeit_kunde_zu v04
   ON t01.mandant_id = v04.mandant_id
   AND v04.arthiertyp_id = -1   
   AND v04.mhd_zeitraum_ab <= t01.mhd_zeitraum

   WHERE v04.einstellung_schema = 'Z001'
   GROUP BY t01.mandant_id
   ,t01.art_id
   ,t01.arthiertyp_id
   ,t01.wg_id
   ,t01.wug_id;