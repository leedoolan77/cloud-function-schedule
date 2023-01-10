########## global imports ##########


########## global vars ##########


########## classes & functions ##########
def process(request):
    try:
        # insert code here
        print("### Running Cloud Function ###")
        return("OK", 200)
    except Exception as e:
        print(e)
        return(e, 500)

########## complete ##########
