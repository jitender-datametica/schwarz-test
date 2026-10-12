CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_GRUPPE_2
-- Erweiterung um Dummywert loesch_fg , gruppe_neu- AblÃ¶se Writeback - sschuecke 11.09.2014
-- Ã×nderung Security AblÃ¶sung Dialog Tabellen - cbru1709 25.04.2018
(
gruppe_id
, gruppe_bez
)
AS

   SELECT
   v01.gruppe_id, v01.gruppe_bez
   FROM dbp_security.gruppe_2 v01
   WHERE v01.gruppe_id <> 0;