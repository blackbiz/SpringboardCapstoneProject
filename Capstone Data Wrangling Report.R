# Capstone Project Data Wrangling Report

# Because this voter file has personal data, it is important that I anonymize the file and remove, or better yet, obfuscate identifiable information. MD5 hash generator is used to scramble the data. (MD6 may be used in the future.)
# These columns include; 
# Voter ID: VOTERID 
# First and Last Names: FIRSTNAME, LASTNAME
# Address: ADDR_NUM, ADDR_FRAC, ADDR_DIR, ADDR_STR, ADDR_TYPE, ADDR_PDIR, ADDR_OTHER, ADDR_ZIP4
# Phone Number: PHONE
# I then cleanup the all date headers to a readable format, data type, and reorder pushing masked data to the rear of the data frame. 
# Columns denoting special elections are removed leaving general and midterm elections.
# NA values in vote data are changed to zeros.


