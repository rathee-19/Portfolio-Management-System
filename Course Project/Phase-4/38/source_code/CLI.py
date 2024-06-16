import subprocess as sp
import pymysql
import pymysql.cursors
from tabulate import tabulate

"""


















"""


def C1():
    # stocks with P/E less than a threshold
    threshold = input("Enter threshold limit for P/E : ")
    float(threshold)

    # query
    try:
        q = "select * from STOCKS where P_to_E < {x};".format(x=threshold)
        CURSOR.execute(q)

        # fetching the data
        data = CURSOR.fetchall()

        # managing data
        headers = {}
        if len(data) > 0:
            first_row_headers = list(data[0].keys())
            for i, header in enumerate(first_row_headers):
                headers[header] = first_row_headers[i]

        # printing data
        print(tabulate(data, headers=headers))

    except Exception as err:
        print(err)


def C2():
    # tax records of a particular type
    taxType = input("Enter type of tax records needed : ")

    # query
    try:
        q = "select * from TAXES where Type = '{x}';".format(x=taxType)
        CURSOR.execute(q)

        # fetching the data
        data = CURSOR.fetchall()

        # managing data
        headers = {}
        if len(data) > 0:
            first_row_headers = list(data[0].keys())
            for i, header in enumerate(first_row_headers):
                headers[header] = first_row_headers[i]

        # printing data
        print(tabulate(data, headers=headers))

    except Exception as err:
        print(err)


def C3():
    # names of all stocks with share price less than a value
    value = input("Enter limit value of share price to get stocks with lesser price : ")
    float(value)

    # query
    try:
        q = "select Stock, Price from STOCKS where Price <= {x};".format(x=value)
        CURSOR.execute(q)

        # fetching the data
        data = CURSOR.fetchall()

        # managing data
        headers = {}
        if len(data) > 0:
            first_row_headers = list(data[0].keys())
            for i, header in enumerate(first_row_headers):
                headers[header] = first_row_headers[i]

        # printing data
        print(tabulate(data, headers=headers))

    except Exception as err:
        print(err)


def C4():
    # MFs owned by a particular PAN
    PAN = input("Enter the PAN to get all the MFs owned by it : ")

    # query
    try:
        q = "select MFID from EQUITIES inner join HOLDINGS on HOLDINGS.HoldingID = EQUITIES.HoldingID inner join PORTFOLIOS on PORTFOLIOS.FolioID = HOLDINGS.FolioID where EQUITIES.StockID is NULL and PORTFOLIOS.PAN = '{x}';".format(
            x=PAN
        )
        CURSOR.execute(q)

        # fetching the data
        data = CURSOR.fetchall()

        # managing data
        headers = {}
        if len(data) > 0:
            first_row_headers = list(data[0].keys())
            for i, header in enumerate(first_row_headers):
                headers[header] = first_row_headers[i]

        # printing data
        print(tabulate(data, headers=headers))

    except Exception as err:
        print(err)


def C5():
    # volume of total trade on a particular date
    givenDate = input("Enter the date to get that day's trade volume : ")

    # query
    try:
        q = "select sum(Qty_change) as Total_volume from TRANSACTIONS group by Date having TRANSACTIONS.Date = '{x}';".format(
            x=givenDate
        )
        CURSOR.execute(q)

        # fetching the data
        data = CURSOR.fetchall()

        # managing data
        volume = int(list(data[0].values())[0])

        # printing data
        if volume < 0:
            print(
                "Total volume of trade on {x} was {y} shares sold.".format(
                    x=givenDate, y=volume
                )
            )
        else:
            print(
                "Total volume of trade on {x} was {y} shares bought.".format(
                    x=givenDate, y=volume
                )
            )

    except Exception as err:
        print(err)


def C6():
    # stock with the biggest market cap

    # query
    try:
        q = "select * from STOCKS where Market_Cap = (select max(Market_Cap) from STOCKS);"
        CURSOR.execute(q)

        # fetching the data
        data = CURSOR.fetchall()

        # managing data
        headers = {}
        if len(data) > 0:
            first_row_headers = list(data[0].keys())
            for i, header in enumerate(first_row_headers):
                headers[header] = first_row_headers[i]

        # printing data
        print(tabulate(data, headers=headers))

    except Exception as err:
        print(err)


def C7():
    # all MF belonging to a particular company
    companyName = input("Enter the company name to get its all MF : ")

    # query
    try:
        q = "select * from MUTUALFUNDS where Fund like '{x}%';".format(x=companyName)
        CURSOR.execute(q)

        # fetching the data
        data = CURSOR.fetchall()

        # managing data
        headers = {}
        if len(data) > 0:
            first_row_headers = list(data[0].keys())
            for i, header in enumerate(first_row_headers):
                headers[header] = first_row_headers[i]

        # printing data
        print(tabulate(data, headers=headers))

    except Exception as err:
        print(err)


def C8():
    # details of all transactions in a particular year and month
    year = input("Enter the year number : ")
    month = input("Enter the month number to get those transactions : ")

    # query
    try:
        q = "select * from TRANSACTIONS where Date like '{x}-{y}-%';".format(
            x=year, y=month
        )
        CURSOR.execute(q)

        # fetching the data
        data = CURSOR.fetchall()

        # managing data
        headers = {}
        if len(data) > 0:
            first_row_headers = list(data[0].keys())
            for i, header in enumerate(first_row_headers):
                headers[header] = first_row_headers[i]

        # printing data
        print(tabulate(data, headers=headers))

    except Exception as err:
        print(err)


def C9():
    # to insert new users to the DB
    newStockID = input("Enter the new stock ID : ")
    newStockName = input("Enter the stock name : ")
    newPrice = float(input("Enter the price : "))
    newGain_Loss = float(input("Enter the gain/loss : "))
    newTotalShares = int(input("Enter the total shares : "))
    newMarketCap = float(input("Enter the market cap : "))
    newBV = float(input("Enter the book value : "))
    newPE = float(input("Enter the P/E : "))

    # query
    try:
        q = "insert into STOCKS values ('{x}', '{y}', {z}, {a}, {b}, {c}, {d}, {e});".format(
            x=newStockID,
            y=newStockName,
            z=newPrice,
            a=newGain_Loss,
            b=newTotalShares,
            c=newMarketCap,
            d=newBV,
            e=newPE,
        )
        CURSOR.execute(q)
        print(q)

    except Exception as err:
        print(err)


def C10():
    # to insert new transactions to the DB
    TransID = input("Enter the transaction ID : ")
    FolioID = input("Enter the folio ID : ")
    HoldingID = input("Enter the holding ID : ")
    transType = input("Enter the transaction type : ")
    transDate = input("Enter the transaction date (yyyy-mm-dd) : ")
    qtyChange = input("Enter the quantity change : ")
    int(qtyChange)

    # query
    try:
        q = "insert into TRANSACTIONS values ('{x}', '{y}', '{z}', '{a}', '{b}', {c});".format(
            x=TransID, y=FolioID, z=HoldingID, a=transType, b=transDate, c=qtyChange
        )
        CURSOR.execute(q)
    except Exception as err:
        print(err)


def C11():
    # to update live stock prices & daily gain/loss
    stockID = input("Enter the stock ID for upating the price : ")
    newPrice = input("Enter the new price : ")
    float(newPrice)

    # query
    try:
        q = "update STOCKS set Price = {x} where StockID = '{y}';".format(
            x=newPrice, y=stockID
        )
        CURSOR.execute(q)
    except Exception as err:
        print(err)


def C12():
    # to update number of shares of a particular MF
    MFID = input("Enter the MF ID for upating the number of shares : ")
    numShares = input("Enter the new number of shares : ")
    int(numShares)

    # query
    try:
        q = "update MUTUALFUNDS set Total_shares = {x} where MFID = '{y}';".format(
            x=numShares, y=MFID
        )
        CURSOR.execute(q)
    except Exception as err:
        print(err)


def C13():
    # to delete a folio of any user
    folioID = input("Enter the FolioID to be deleted : ")

    # query
    try:
        q = "delete from PORTFOLIOS where FolioID = '{x}';".format(x=folioID)
        CURSOR.execute(q)
    except Exception as err:
        print(err)


def C14():
    # to delete a stock from the market
    StockID = input("Enter the stock ID of the stock to be deleted : ")

    # query
    try:
        q = "delete from STOCKS where StockID = '{x}';".format(x=StockID)
        CURSOR.execute(q)
    except Exception as err:
        print(err)


def C15():
    # get report of gain/loss seperately incurred from stocks & MF for any folio
    folioID = input("Enter the folio ID for getting Gain/Loss report : ")

    # query 1 for Stocks
    GL_stocks = 0
    float(GL_stocks)
    try:
        q = "select sum(Net_Gain_Loss) as Total_GL from HOLDINGS where HOLDINGS.HoldingID in (select EQUITIES.HoldingID as HID from EQUITIES where EQUITIES.MFID is NULL) and HOLDINGS.FolioID = '{x}';".format(
            x=folioID
        )
        CURSOR.execute(q)

        # setting value
        data = CURSOR.fetchall()
        GL_stocks = int(list(data[0].values())[0])

    except Exception as err:
        print(err)

    # query 2 for MF
    GL_MF = 0
    float(GL_MF)
    try:
        q = (
            "select sum(Net_Gain_Loss) as Total_GL from HOLDINGS "
            "where HOLDINGS.HoldingID in (select EQUITIES.HoldingID as HID from EQUITIES where EQUITIES.StockID is NULL) "
            "and HOLDINGS.FolioID = '{x}';".format(x=folioID)
        )
        CURSOR.execute(q)

        # setting value
        data = CURSOR.fetchall()
        GL_MF = int(list(data[0].values())[0])

    except Exception as err:
        print(err)

    # printing the output
    print("Gain/Loss from Stocks is {x}".format(x=GL_stocks))
    print("Gain/Loss from MF is {x}".format(x=GL_MF))


def C16():
    # get report of total tax incurred over all transactions by any individual
    userPAN = input("Enter the PAN of the user for tax calculation : ")

    # query
    try:
        q = "select PORTFOLIOS.PAN, sum(TAXES.Amount) as Total_tax from TAXES inner join TRANSACTIONS on TAXES.TransID = TRANSACTIONS.TransID inner join PORTFOLIOS on TRANSACTIONS.FolioID = PORTFOLIOS.FolioID group by PORTFOLIOS.PAN having PORTFOLIOS.PAN = '{x}';".format(
            x=userPAN
        )
        CURSOR.execute(q)

        # setting value
        data = CURSOR.fetchall()
        totalTax = float(list(data[0].values())[1])

        # printing the output
        print("Total tax incurred by PAN-'{x}' is {y}".format(x=userPAN, y=totalTax))

    except Exception as err:
        print(err)


"""




























"""


def query_caller(choice):
    if choice == 1:
        C1()
    elif choice == 2:
        C2()
    elif choice == 3:
        C3()
    elif choice == 4:
        C4()
    elif choice == 5:
        C5()
    elif choice == 6:
        C6()
    elif choice == 7:
        C7()
    elif choice == 8:
        C8()
    elif choice == 9:
        C9()
    elif choice == 10:
        C10()
    elif choice == 11:
        C11()
    elif choice == 12:
        C12()
    elif choice == 13:
        C13()
    elif choice == 14:
        C14()
    elif choice == 15:
        C15()
    elif choice == 16:
        C16()
    else:
        print("Wrong choice entered! Please enter again.")


"""




























"""

# MAIN block
while 1:
    TEMP = sp.call("clear", shell=True)

    # getting username and password as input
    PASSWORD = input("Enter your password : ")

    # initial TRY block
    try:
        # making connection
        CONNECTION = pymysql.connect(
            host="localhost",
            port=3306,
            user="root",
            password=PASSWORD,
            db="PORTFOLIO_MANAGEMENT",
            cursorclass=pymysql.cursors.DictCursor,
        )
        tmp = sp.call("clear", shell=True)

        # something
        if CONNECTION.open:
            print("Connected successfully!")
        else:
            print("Failed to connect!")
            continue

        with CONNECTION.cursor() as CURSOR:
            # moving on
            tmp = input("Press ENTER to continue!")
            while 1:
                tmp = sp.call("clear", shell=True)

                # getting the operation to be performed
                print(
                    "=============================================================================================="
                )
                print("1  -> stocks with P/E less than a threshold")
                print("2  -> tax records of a particular type")
                print("3  -> names of all stocks with share price lesser than a value")
                print("4  -> MFs owned by a particular PAN")
                print(
                    "5  -> volume (qty of shares bought/sold) of total trade on a particular date"
                )
                print("6  -> stock with the biggest market cap")
                print("7  -> all MF belonging to a particular company")
                print(
                    "8  -> details of all transactions in a particular year and month"
                )
                print("9  -> to insert new Stock")
                print("10 -> to insert new transactions to the DB")
                print("11 -> to update live stock prices & daily gain/loss")
                print("12 -> to update number of shares of a particular MF")
                print("13 -> to delete a folio of any user")
                print("14 -> to delete a stock from the market")
                print(
                    "15 -> get report of gain/loss seperately incurred from stocks & MF for any folio"
                )
                print(
                    "16 -> get report of total tax incurred over all transactions by any individual"
                )
                print("0  -> Logout")
                print(
                    "=============================================================================================="
                )
                choice = int(input("Enter choice : "))
                tmp = sp.call("clear", shell=True)
                if choice == 0:
                    CURSOR.close()
                    CONNECTION.close()
                    exit()
                else:
                    # function to run the operation query
                    query_caller(choice)

                    # commiting the changes
                    CONNECTION.commit()

                    # moving on
                    tmp = input("\nPress ENTER to continue!")

    except Exception as e:
        print(e)
        tmp = input("Press any key to continue!")
