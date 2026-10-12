CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_SCANS_PRO_MINUTE
AS
 -- FAKT Scans/min pro Kassierer
 -- 2020.0625 ssch0611 : initial (AP0063657_SPEC0079216)
 
SELECT
  spm.mandant_id
, spm.nb_id
, spm.wup_id
, spm.kassierer_nr
, spm.dat
, zeit.kjwo
, zeit.kjmo

, spm.anz_artikel                                                                                                           AS anz_artikel_tag -- daily
, Sum(spm.anz_artikel) Over (PARTITION BY spm.mandant_id, spm.nb_id, spm.wup_id, spm.kassierer_nr, spm.kjwo)                AS anz_artikel_wo  -- weekly
, Sum(spm.anz_artikel) Over (PARTITION BY spm.mandant_id, spm.nb_id, spm.wup_id, spm.kassierer_nr, zeit.kjmo)               AS anz_artikel_mo  -- monthly
, spm.registrierzeit -- not used (value in seconds)
, spm.registrierzeit / 60.0000                                                                                              AS scanzeit_tag   -- daily (minutes)
, Sum(spm.registrierzeit) Over (PARTITION BY spm.mandant_id, spm.nb_id, spm.wup_id, spm.kassierer_nr, spm.kjwo) / 60.0000   AS scanzeit_wo    -- weekly (minutes)
, Sum(spm.registrierzeit) Over (PARTITION BY spm.mandant_id, spm.nb_id, spm.wup_id, spm.kassierer_nr, zeit.kjmo) / 60.0000  AS scanzeit_mo    -- monthly (minutes)
, anz_artikel_tag / NullIfZero (scanzeit_tag) AS scans_min_tag
, anz_artikel_wo / NullIfZero (scanzeit_wo)   AS scans_min_wo
, anz_artikel_mo / NullIfZero (scanzeit_mo)   AS scans_min_mo

FROM dbp_v_ods.v_scans_pro_minute spm

JOIN dbp_view.v_tag zeit
ON spm.dat = zeit.dat 
;