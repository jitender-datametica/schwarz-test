CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_AMX_L_HAUPTBEREICH_2
AS
-- 20160322 KKaiser, neu für AP0002158 Audimex
-- 20190814 twie: SPEC0059325 Nur relevante Hauptbereiche für das Cockpit anzeigen, dafür Join auf Filtertabelle
-- 2019.0917 ssch0611 : SORT + KBEZ(dummy_2) added
-- 20200326 lsvi: SPEC0073867 OneAudimex filter amx_system_id=1
SELECT 
  v01.hauptbereich_id
, v02.platzhalter_sort AS hauptbereich_sort    
, v01.hauptbereich_bez
, v01.hauptbereich_bez AS hauptbereich_kbez -- dummy_2 (until defined)
FROM dbp_view.v_amx_l_hauptbereich_2 v01
INNER JOIN dbp_view.v_amx_filter_benutzeroberflaeche_2 v02
ON v01.hauptbereich_id = v02.platzhalter_id
 -- Typ 1 = Hauptbereich
WHERE v02.amx_filter_typ_id = 1
AND v01.amx_system_id=1
AND v02.amx_system_id=1;