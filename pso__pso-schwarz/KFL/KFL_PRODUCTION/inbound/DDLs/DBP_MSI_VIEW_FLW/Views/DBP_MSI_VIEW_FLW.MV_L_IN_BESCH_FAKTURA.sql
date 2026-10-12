CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_IN_BESCH_FAKTURA
-- 26.10.2011 system_id entfernt
--08.10.2012 twie: in_kunde_id hinzu (Auftragggeber)
-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
faktura_beleg_id
, mandant_id
--, system_id
, in_vw_id
, dat_faktura
, dat_erstellung
, fakturaart_id
, in_kunde_id
,faktura_status_kz

)
AS
   SELECT
   faktura_beleg_id, mandant_id, flw_vw_id AS in_vw_id, dat_faktura, dat_erstellung, fakturaart_id, flw_kunde_id AS in_kunde_id, faktura_status_kz

   FROM dbp_view.v_flw_besch_faktura;