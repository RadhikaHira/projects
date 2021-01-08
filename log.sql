-- Keep a log of any SQL queries you execute as you solve the mystery.
--first lok at the crime report for that street and day
SELECT * FROM crime_scene_reports
WHERE street = 'Chamberlin Street' AND day = 28;

--Theft of the CS50 duck took place at 10:15am at the
--Chamberlin Street courthouse. Interviews were conducted today
--with three witnesses who were present at the time — each of
--their interview transcripts mentions the courthouse.

--Start with checking the interviews of the 3 witnesses
SELECT * FROM interviews
WHERE month = 7 AND day = 28;

-- id | name | year | month | day | transcript
--160 | Barbara | 2020 | 7 | 28 | “You had my note?” he asked with a deep harsh voice and a strongly marked German accent. “I told you that I would call.” He looked from one to the other of us, as if uncertain which to address.

--161 | Ruth | 2020 | 7 | 28 | Sometime within ten minutes of the theft, I saw the thief get into a car in the courthouse parking lot and drive away. If you have security footage from the courthouse parking lot, you might want to look for cars that left the parking lot in that time frame.

--162 | Eugene | 2020 | 7 | 28 | I don't know the thief's name, but it was someone I recognized. Earlier this morning, before I arrived at the courthouse, I was walking by the ATM on Fifer Street and saw the thief there withdrawing some money.

--163 | Raymond | 2020 | 7 | 28 | As the thief was leaving the courthouse, they called someone who talked to them for less than a minute. In the call, I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow. The thief then asked the person on the other end of the phone to purchase the flight ticket.

-- id 160, 161, 162, 163
-- everything after theif left the courthouse
-- courthouse_security_logs, atm_transactions
-- people, phone_calls, flights, airports

-- see courthoust logs for who LEFT around the time of the theft
SELECT * FROM courthouse_security_logs
WHERE month = 7 AND day = 28;

--id  |year |month|day|hour|minute|activity|license_plate
--254 | 2020 | 7 | 28 | 9 | 14 | entrance | 4328GD8  <-Danielle
--255 | 2020 | 7 | 28 | 9 | 15 | entrance | 5P2BI95
--256 | 2020 | 7 | 28 | 9 | 20 | entrance | 6P58WS2
--257 | 2020 | 7 | 28 | 9 | 28 | entrance | G412CB7
--258 | 2020 | 7 | 28 | 10 | 8 | entrance | R3G7486
--259 | 2020 | 7 | 28 | 10 | 14 | entrance | 13FNH73
--260 | 2020 | 7 | 28 | 10 | 16 | exit | 5P2BI95
--261 | 2020 | 7 | 28 | 10 | 18 | exit | 94KL13X  <-Ernest
--262 | 2020 | 7 | 28 | 10 | 18 | exit | 6P58WS2
--263 | 2020 | 7 | 28 | 10 | 19 | exit | 4328GD8  <-Danielle
--264 | 2020 | 7 | 28 | 10 | 20 | exit | G412CB7
--265 | 2020 | 7 | 28 | 10 | 21 | exit | L93JTIZ
--266 | 2020 | 7 | 28 | 10 | 23 | exit | 322W7JE  <-Russell
--267 | 2020 | 7 | 28 | 10 | 23 | exit | 0NTHK55
--268 | 2020 | 7 | 28 | 10 | 35 | exit | 1106N58  <-Madison

--Theif was withdrawing money as id:162 said
SELECT * FROM atm_transactions
WHERE atm_location = 'Fifer Street' AND year = 2020 AND month = 7 AND day = 28;

--id | account_number | year | month | day | atm_location | transaction_type | amount
--246 | 28500762 | 2020 | 7 | 28 | Fifer Street | withdraw | 48
--264 | 28296815 | 2020 | 7 | 28 | Fifer Street | withdraw | 20
--266 | 76054385 | 2020 | 7 | 28 | Fifer Street | withdraw | 60
--267 | 49610011 | 2020 | 7 | 28 | Fifer Street | withdraw | 50
--269 | 16153065 | 2020 | 7 | 28 | Fifer Street | withdraw | 80
--288 | 16153065 | 2020 | 7 | 28 | Fifer Street | withdraw | 20
--313 | 81061156 | 2020 | 7 | 28 | Fifer Street | withdraw | 30
--336 | 26013199 | 2020 | 7 | 28 | Fifer Street | withdraw | 35

--finding people with these account numbers
SELECT * FROM bank_accounts
JOIN people ON bank_accounts.person_id = people.id
WHERE account_number IN ('28500762', '28296815','76054385','49610011','16153065','16153065','81061156','26013199');

--account_number | person_id | creation_year | id | name | phone_number | passport_number | license_plate
--49610011 | 686048 | 2010 | 686048 | Ernest | (367) 555-5533 | 5773159633 | 94KL13X
--26013199 | 514354 | 2012 | 514354 | Russell | (770) 555-1861 | 3592750733 | 322W7JE
--16153065 | 458378 | 2012 | 458378 | Roy | (122) 555-4581 | 4408372428 | QX4YZN3
--28296815 | 395717 | 2014 | 395717 | Bobby | (826) 555-1652 | 9878712108 | 30G67EN
--28500762 | 467400 | 2014 | 467400 | Danielle | (389) 555-5198 | 8496433585 | 4328GD8
--76054385 | 449774 | 2015 | 449774 | Madison | (286) 555-6063 | 1988161715 | 1106N58
--81061156 | 438727 | 2018 | 438727 | Victoria | (338) 555-6650 | 9586786673 | 8X428L0

--the theif CALLED someone and talked for less than a minute
SELECT * FROM phone_calls
WHERE year = 2020 AND month = 7 AND day = 28 AND duration <= 60;

--id | caller | receiver | year | month | day | duration
--221 | (130) 555-0289 | (996) 555-8899 | 2020 | 7 | 28 | 51
--224 | (499) 555-9472 | (892) 555-8872 | 2020 | 7 | 28 | 36
--233 | (367) 555-5533 | (375) 555-8161 | 2020 | 7 | 28 | 45   <-Ernest
--234 | (609) 555-5876 | (389) 555-5198 | 2020 | 7 | 28 | 60   <-Danielle recieved a call
--251 | (499) 555-9472 | (717) 555-1342 | 2020 | 7 | 28 | 50
--254 | (286) 555-6063 | (676) 555-6554 | 2020 | 7 | 28 | 43   <-Madison
--255 | (770) 555-1861 | (725) 555-3243 | 2020 | 7 | 28 | 49   <-Russell
--261 | (031) 555-6622 | (910) 555-3251 | 2020 | 7 | 28 | 38
--279 | (826) 555-1652 | (066) 555-9701 | 2020 | 7 | 28 | 55   <-Bobby
--281 | (338) 555-6650 | (704) 555-2131 | 2020 | 7 | 28 | 54   <-Victoria

--Danielle recieved a call, so she cannot be the theif. So only 5 suspects

--Check who Ernest, Madison, Russell, Bobby, Victoria called (in order)
SELECT * FROM people
WHERE phone_number IN ('(375) 555-8161', '(676) 555-6554', '(725) 555-3243', '(066) 555-9701', '(704) 555-2131');

-- id | name | phone_number | passport_number | license_plate
--Ernest called: 864400 | Berthold | (375) 555-8161 |  | 4V16VO0
--Madison called: 250277 | James | (676) 555-6554 | 2438825627 | Q13SVG6
--Russell called: 847116 | Philip | (725) 555-3243 | 3391710505 | GW362R6
--Bobby called: 953679 | Doris | (066) 555-9701 | 7214083635 | M51FA04
--Victoria called: 484375 | Anna | (704) 555-2131 |  |


SELECT * FROM airports
WHERE city = 'Fiftyville';

--id | abbreviation | full_name | city
--8 | CSF | Fiftyville Regional Airport | Fiftyville

--check flights for next day
SELECT * FROM flights
JOIN airports ON flights.origin_airport_id = airports.id
WHERE origin_airport_id = 8 AND year = 2020 AND month = 7 AND day = 29;

--id | origin_airport_id | destination_airport_id | year | month | day | hour | minute | id | abbreviation | full_name | city
--36 | 8 | 4 | 2020 | 7 | 29 | 8 | 20 | 8 | CSF | Fiftyville Regional Airport | Fiftyville
--43 | 8 | 1 | 2020 | 7 | 29 | 9 | 30 | 8 | CSF | Fiftyville Regional Airport | Fiftyville


--Check passport number of suspects
--Ernest, Madison, Russell, Bobby, Victoria (in that order)
SELECT * FROM passengers
JOIN flights ON passengers.flight_id =flights.id
WHERE passport_number IN ('5773159633', '1988161715', '3592750733', '9878712108', '9586786673');


--flight_id | passport_number | seat | id | origin_airport_id | destination_airport_id | year | month | day | hour | minute
--Russell: 18 | 3592750733 | 4C | 18 | 8 | 6 | 2020 | 7 | 29 | 16 | 0
--Ernest: 36 | 5773159633 | 4A | 36 | 8 | 4 | 2020 | 7 | 29 | 8 | 20
--Madison: 36 | 1988161715 | 6D | 36 | 8 | 4 | 2020 | 7 | 29 | 8 | 20
--Bobby: 36 | 9878712108 | 7A | 36 | 8 | 4 | 2020 | 7 | 29 | 8 | 20

--the earliest flight the next day is the 8:20 for Ernest, Madison and Bobby
-- 3 suspects since Russell is taking a later flight


--finding accomplice suspects
SELECT * FROM people
WHERE name IN ('Berthold', 'James','Doris');

--id | name | phone_number | passport_number | license_plate
--864400 | Berthold | (375) 555-8161 |  | 4V16VO0
--250277 | James | (676) 555-6554 | 2438825627 | Q13SVG6
--953679 | Doris | (066) 555-9701 | 7214083635 | M51FA04

--Ernest called: Berthold who doesnt have a passport number
--Since Raymond said that the theif asked the accomplice
-- to purchase a ticket, that means Berthold was not going
--  becouse he has no passport number

--checking passport for those 3 
--and make sure origin airport is fiftyville (8)
SELECT * FROM passengers
JOIN flights ON passengers.flight_id = flights.id
WHERE passport_number IN ('?','2438825627','7214083635') AND origin_airport_id = '8';

--flight_id | passport_number | seat | id | origin_airport_id | destination_airport_id | year | month | day | hour | minute
--10 | 2438825627 | 7C | 10 | 8 | 4 | 2020 | 7 | 30 | 13 | 55
--36 | 7214083635 | 2A | 36 | 8 | 4 | 2020 | 7 | 29 | 8 | 20

--Seems like Berthold is the accomplice meaning Ernest is the theif 
--now to find where the theif went 

SELECT * FROM flights
JOIN airports ON destination_airport_id = airports.id
WHERE destination_airport_id = '4';

--id | origin_airport_id | destination_airport_id | year | month | day | hour | minute | id | abbreviation | full_name | city
--10 | 8 | 4 | 2020 | 7 | 30 | 13 | 55 | 4 | LHR | Heathrow Airport | London
--17 | 8 | 4 | 2020 | 7 | 28 | 20 | 16 | 4 | LHR | Heathrow Airport | London
--35 | 8 | 4 | 2020 | 7 | 28 | 16 | 16 | 4 | LHR | Heathrow Airport | London
--36 | 8 | 4 | 2020 | 7 | 29 | 8 | 20 | 4 | LHR | Heathrow Airport | London
--55 | 8 | 4 | 2020 | 7 | 26 | 21 | 44 | 4 | LHR | Heathrow Airport | London

--The theif went to london
