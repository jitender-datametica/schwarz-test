--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    W1.kjwo,
    S1.kjmo_sort AS kjmo
FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_2 AS S1
INNER JOIN dbp_data.woche_2 AS W1 ON S1.kjwo_bis >= W1.kjwo
INNER JOIN dbp_data.monat_2 AS M1 ON S1.kjmo_sort = M1.kjmo
INNER JOIN dbp_data.monat_2 AS M2 ON M2.akt_mo = M1.akt_mo - 1
INNER JOIN
    dbp_msi_data.ek_sort_sortiment_mat_zeitraum_2 AS S2
    ON M2.kjmo = S2.kjmo_sort
INNER JOIN dbp_data.woche_2 AS W2 ON S2.kjwo_bis < W2.kjwo
WHERE W2.kjwo = W1.kjwo;
