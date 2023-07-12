SPACES tSQL STATEMENTS
-- A
BEGIN TRANSACTION
GO
SET IDENTITY_INSERT [Client] ON;
INSERT INTO [Client] (id, firstname, lastname, email, phone, business, address, city, country, postcode) values (101, 'Leeanne', 'Rubrow', 'lrubrow1i@guardian.co.uk', 762-501-6339, 'Spaces ltd.', '163 Sabrina Blv', 'York', 'England', 6501)
SET IDENTITY_INSERT [Client] OFF;
INSERT INTO [Contract] (id, Clientid, SalesRepEmployeeProfileID, signeddate, status) values (101, 101, 68, '2023-07-01', 'current')
INSERT INTO [Subscription] (id, Contractid, Levelsid, discount, status, lastpay, nextpay) values (101, 101, 1, 'true', 'subscribed', '2023-07-01', '2024-07-01')
SELECT [Subscription].id, Clientid, Contractid, Levelsid, discount, firstname, lastname
FROM [Subscription]
LEFT JOIN [Contract] on Contractid = [Contract].id
INNER JOIN [Client] on Clientid = [Client].id
WHERE [Subscription].id = 101

-- B
BEGIN TRANSACTION
SELECT [Contract].SalesRepEmployeeProfileID, [Employee Profile].firstname AS SalesRep1stNme, [Employee Profile].lastname AS SalesRep2ndNme, 
[Client].id AS Clientid, [Client].firstname AS Client1stNme, [Client].lastname AS Client2ndNme, [Client].address AS ClientAddrss
FROM [Contract]
LEFT JOIN [Sales Rep] on [Contract].SalesRepEmployeeProfileID = [Sales Rep].EmployeeProfileid
LEFT JOIN [Employee Profile] on [Contract].SalesRepEmployeeProfileID = [Employee Profile].id
RIGHT JOIN [Client] on [Contract].Clientid = [Client].id
ORDER BY [Contract].SalesRepEmployeeProfileID

-- C
BEGIN TRANSACTION
SET IDENTITY_INSERT [Stream] ON;
insert into [Stream] (id, Sensorid, [date], [start], [end]) values (101, 56, '2023-07-18', '14:30', '20:40');
SET IDENTITY_INSERT [Stream] OFF;
SET IDENTITY_INSERT [Recording] ON;
insert into [Recording] (id, Streamid, Sensorid, [video], audio, bodyimagry, [length], [size]) 
values (101, 101, 56, 'BlackMirror.avi', 'LochHenry.wav', 'Joan.cad', '6:23:45', 6548);
SET IDENTITY_INSERT [Recording] OFF;
SET IDENTITY_INSERT [Data] ON;
insert into [Data] (id, Streamid, Recordingid, [date], expires) values (101, 101, 101, '2023-07-18', '2023-08-18');
SET IDENTITY_INSERT [Data] OFF;
SELECT [Recording].id AS Recordingid, [Recording].Streamid, [Data].id AS Dataid, [Data].date
FROM [Recording] 
LEFT JOIN [Data] on [Recording].id = [Data].Recordingid
WHERE [Recording].id = '101'
-- D
SELECT [Sensor].id, [Sensor].coordinates, [Stream Schedule].Clientid, [Client].firstname, [Client].lastname, [Client].business
FROM [Sensor] 
LEFT JOIN [Stream Schedule] on [Sensor].id = [Stream Schedule].Sensorid
RIGHT JOIN [Client] on [Client].id = [Stream Schedule].Clientid
WHERE [Client].business IS NOT NULL
-- E

-- F
SELECT sensorid, streamid, clientid, firstname, lastname from [Stream Schedule]
LEFT JOIN [Client] on [client].id = clientid
ORDER BY Streamid asc;

-- G
SELECT orderno, sensorid, [Supply Order].Suppliersupplycode, [Supplier].company, productid, [Product].name
FROM [Supply Order] 
LEFT JOIN [Supplier] on [Supplier].supplycode = [Supply Order].Suppliersupplycode
INNER JOIN [Product] on [Product].id = productid
WHERE sensorid = '31';

-- H
BEGIN TRANSACTION
UPDATE [Sensor]
SET Zoneid = '55', coordinates = 37.83295626
WHERE id = '32'
SELECT * FROM [Sensor]
WHERE id = '32'

-- I Delete the data for a given contract (Requires subscription delete as contract = subscription
BEGIN TRANSACTION
GO
DELETE FROM [Subscription] WHERE Contractid = '88';
DELETE FROM [Contract] WHERE id = '88'
Print 'Contract Deleted'
GO
Rollback transaction/Commit transaction

-- J
SELECT [Supply Order].Sensorid, SUM([Supply Order].quantity*[Product].price) AS totalrepairprice
FROM [Supply Order]
LEFT JOIN [Product] on [Supply Order].Productid = [Product].id
GROUP BY Sensorid
ORDER BY Sensorid asc;