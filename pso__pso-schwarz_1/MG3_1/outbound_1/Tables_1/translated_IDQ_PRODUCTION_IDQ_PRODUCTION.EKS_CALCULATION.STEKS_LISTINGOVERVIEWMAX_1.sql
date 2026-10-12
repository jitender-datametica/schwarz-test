CREATE OR REPLACE TABLE idq_production_eks_calculation.steks_listingoverviewmax_1 (
listingoverviewid INTEGER NOT NULL,
location_1 STRING(5),
supplierno INTEGER,
cr_locationid INTEGER,
receivingcountry STRING(5),
itemid INTEGER,
casesize INTEGER,
zitem_ba INTEGER,
zarticletype STRING(2),
zactive INTEGER DEFAULT 0 NOT NULL
);