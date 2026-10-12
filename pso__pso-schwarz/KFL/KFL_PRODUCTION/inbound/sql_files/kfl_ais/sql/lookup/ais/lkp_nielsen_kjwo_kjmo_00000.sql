--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT w1.kjwo,s1.kjmo_sort as kjmo
FROM DBP_MSI_DATA.EK_SORT_SORTIMENT_MAT_ZEITRAUM s1
INNER JOIN DBP_DATA.woche w1
ON w1.kjwo <= s1.kjwo_bis
INNER JOIN DBP_DATA.monat m1
ON m1.kjmo = s1.kjmo_sort
INNER JOIN DBP_DATA.monat m2
ON m2.akt_mo = m1.akt_mo -1
INNER JOIN DBP_MSI_DATA.EK_SORT_SORTIMENT_MAT_ZEITRAUM s2
ON s2.kjmo_sort = m2.kjmo
INNER JOIN DBP_DATA.woche w2
ON w2.kjwo > s2.kjwo_bis
WHERE w2.kjwo = w1.kjwo;

