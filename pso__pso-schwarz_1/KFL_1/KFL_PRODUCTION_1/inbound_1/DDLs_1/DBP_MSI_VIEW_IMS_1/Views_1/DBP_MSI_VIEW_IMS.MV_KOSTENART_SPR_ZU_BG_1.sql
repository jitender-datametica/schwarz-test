CREATE OR REPLACE VIEW dbp_msi_view_ims.mv_kostenart_spr_zu_bg_1
-- 22.03.2013 twie: Sprachzuordung für Kostenarten
-- 27.06.2013 twie: wenn keine Landessprache (ls) vorhanden ist, de ausgeben
-- 20.08.2013 twie: mandant_id nicht mit ausgeben
-- 20.08.2013/Gia

AS
SELECT 
COLLATE(LTRIM(COLLATE(de.kostenart_id,''),'0'), 'en-ci') AS kostenart_id,
de.krk_id,
COALESCE(ls.kostenart_bez, de.kostenart_bez) AS kostenart_bez
FROM dbp_view.v_kostenart_spr_zu_1  de

LEFT OUTER JOIN
(SELECT
*
FROM dbp_view.v_kostenart_spr_zu_1
WHERE spr_id = 18
AND krk_id='XX01'
AND mandant_id = 1
) ls
ON de.kostenart_id = ls.kostenart_id

WHERE de.spr_id = 22
AND de.krk_id='XX01'
AND de.mandant_id = 1
;
