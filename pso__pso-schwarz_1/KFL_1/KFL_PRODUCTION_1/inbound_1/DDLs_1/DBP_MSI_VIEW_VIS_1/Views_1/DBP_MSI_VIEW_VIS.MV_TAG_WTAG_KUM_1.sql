CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_TAG_WTAG_KUM_1
-- 05.08.2015 srom: zum Tag_1 die 4 vorherigen gleichen Wochentage und die VJ-Tage
-- z.B. Montag und die 4 vorherigen Montage
-- 17.08.2015 srom: Umstellung auf die gleichen Wochentage des abgeschlossenen Vormonats.
--                  Sowohl der aktuelle, als auch der zu planende Folgemonat beziehen sich auf den gleichen abgeschlossenen Monat_1
-- 23.12.2016 srom: INC0983925, akt_mo_komplett auf 3 Monate erweitert
(
dat
,dat_kum
,dat_kum_vj
)
AS
   SELECT akt.dat, vor_wochen.dat AS dat_kum, vor_wochen.dat_vj AS dat_kum_vj
   FROM dbp_view.v_tag_1 akt
   INNER JOIN dbp_view.v_tag_1 vor_wochen
   ON akt.dat > vor_wochen.dat
   AND akt.wtag_id = vor_wochen.wtag_id
   WHERE akt.akt_mo_komplett BETWEEN 1 AND 3
   AND vor_wochen.akt_mo_komplett = 0;