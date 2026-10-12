CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_KOMPENSATION_GRUPPE_2
-- 2019.08.06. srom0404, AP0036938, SPEC0049514, Artikel_2 Kompensation
-- Hinweis: In der Tabelle kompensation_gruppe_2 gibt es ein Feld komp_kriterium_bez. Dieses ist noch nicht verbaut.
-- Hinweis:wenn dieses Feld benutzt wird, könnte man die Views mv_kompensation_krit_spr_zu_2* umbenennen, um das nicht mit dem hier 
-- Hinweis: möglichen komp_kriterium_bez zu vermischen
(
 mandant_id
,ZCGNR
,ZCGNAME
,KOMP_KRITERIUM_BEZ
,ZAPPROVE
,anz_art_komp_gruppe
)
AS
  --10.10.2024, prescherad, SPEC0255380, Erweiterung um Komponenten_Kriterium_Bez
    SELECT
    mandant_id, komp_gruppe_id  AS ZCGNR, 
    komp_gruppe_bez AS ZCGNAME, 
    komp_kriterium_bez, 
    freigabe_fg AS ZAPPROVE, 
    anz_art_komp_gruppe
    FROM dbp_view.v_kompensation_gruppe_2;