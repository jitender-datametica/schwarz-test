CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_L_GEKU_BEREICH_2
(
 geku_bereich_uid
,geku_bereich_id
,KDC_fg
,MZK_fg
,WMD_fg
,sec_kz
)
AS
-- 09.09.2015 twie: Lookup für Bereich (1. Ebene)
--                            Filterung über Grund (2. Ebene) damit für Bereich keine Elemente angezeigt werden
--                            für die es keine Kindelemente gibt (Dateileichen, können nie ein Ticket zugeordnet haben)
-- 21.07.2017 twie: SPEC0025359 neues Security Kennzeichen für Sicherheitsfilter
-- 12.10.2022 twie: SPEC0167837 sek_kz von variabel 1 - 7 auf 3 geändert

   SELECT
   geku_bereich_uid
   , geku_bereich_id
   , KDC_fg
   , MZK_fg
   , WMD_fg
   , 3 ::BYTEINT AS sec_kz

   FROM dbp_view.v_l_geku_bereich_2

   WHERE geku_bereich_uid IN
   (SELECT geku_bereich_uid FROM dbp_view.v_l_geku_grund_2);