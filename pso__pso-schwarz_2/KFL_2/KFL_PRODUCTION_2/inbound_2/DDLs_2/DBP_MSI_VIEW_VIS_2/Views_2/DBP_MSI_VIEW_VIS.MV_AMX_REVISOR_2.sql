CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_AMX_REVISOR_2
-- 20160322 KKaiser, neu für AP0002158 Audimex
-- 20160323 twie: name zusammensetzen
-- 20170914 twie: SPEC0026683 Tabelle enthält nur noch 1 Eintrag mit -1 'dummy_2'
--                           Grund: Revisor wurde aus Datenschutzgründen ausgebaut und darf nicht ohne Rücksprache mit SBIT wieder eingebaut werden.
(
revisor_id
,revisor_anrede
,revisor_nachname
,revisor_vorname
,revisor_name

)
AS
   SELECT
   revisor_id, revisor_anrede, revisor_nachname, revisor_vorname, TRIM(revisor_anrede) || ' ' || TRIM(revisor_vorname) || ' ' || TRIM(revisor_nachname) AS revisor_name

   FROM dbp_view.v_amx_revisor_2;