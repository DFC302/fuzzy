#!/bin/bash

function fuzzDomainsFile() {
    echo ""
    # If user uses domain file
    if [[ ${domainFile} ]] ; then
        for domain in $( cat ${domainFile} ) ; do
            # if user uses wordlist
            if [[ ${wordlist} ]] ; then
                for line in $( cat ${wordlist} ) ; do
                    if [[ ${domain} == *"FUZZ" ]] ; then
                        statusCode=$( curl -I -k -L ${domain/FUZZ/$line} -s -o /dev/null -w "%{http_code}" )
                        if [[ ${statuscodes} ]] ; then
                            for status in ${statuscodes} ; do
                                if [[ ${status} -eq ${statusCode} ]] ; then
                                    echo -e "${domain/FUZZ/$line}\t${statusCode}"
                                fi
                            done
                        else
                            echo -e "${domain/FUZZ/$line}\t${statusCode}"
                        fi
                    # If user does not use the word FUZZ
                    elif [[ ${domain} != *"FUZZ" ]] ; then
                        statusCode=$( curl -I -k -L ${domain}/$line} -s -o /dev/null -w "%{http_code}" )
                        if [[ ${statuscodes} ]] ; then
                            for status in ${statuscodes} ; do
                                if [[ ${status} -eq ${statusCode} ]] ; then
                                    echo -e "${domain}/${line}\t${statusCode}"
                                fi
                            done
                        else
                            echo -e "${domain}/${line}\t${statusCode}"
                        fi
                    fi
                done

            # if user does not use wordlist
            elif [[ ${word} ]] ; then
                for line in ${word} ; do
                    # If domain contains keyword FUZZ
                    if [[ ${domain} == *"FUZZ" ]] ; then
                        statusCode=$( curl -I -k -L ${domain/FUZZ/$line} -s -o /dev/null -w "%{http_code}" )
                        if [[ ${statuscodes} ]] ; then
                            for status in ${statuscodes} ; do
                                if [[ ${status} -eq ${statusCode} ]] ; then
                                    echo -e "${domain/FUZZ/$line}\t${statusCode}"
                                fi
                            done
                        else
                            echo -e "${domain/FUZZ/$line}\t${statusCode}"
                        fi
                    # If domain does not contain keyword fuzz
                    elif [[ ${domain} != *"FUZZ" ]] ; then
                        statusCode=$( curl -I -k -L ${domain}/${line} -s -o /dev/null -w "%{http_code}" )
                        if [[ ${statuscodes} ]] ; then
                            for status in ${statuscodes} ; do
                                if [[ ${status} -eq ${statusCode} ]] ; then
                                    echo -e "${domain}/${line}\t${statusCode}"
                                fi
                            done
                        else
                            echo -e "${domain}/${line}\t${statusCode}"
                        fi
                    fi
                done
            fi
        done
    fi

    echo ""
}

function fuzzDomains() {
    echo ""

    # If user uses domain flag
    if [[ ${domains} ]] ; then
        for domain in ${domains} ; do
            # if user uses wordlist
            if [[ ${wordlist} ]] ; then
                for line in $( cat ${wordlist} ) ; do
                    if [[ ${domain} == *"FUZZ" ]] ; then
                        statusCode=$( curl -I -k -L ${domain/FUZZ/$line} -s -o /dev/null -w "%{http_code}" )
                        if [[ ${statuscodes} ]] ; then
                            for status in ${statuscodes} ; do
                                if [[ ${status} -eq ${statusCode} ]] ; then
                                    echo -e "${domain/FUZZ/$line}\t${statusCode}"
                                fi
                            done
                        else
                            echo -e "${domain/FUZZ/$line}\t${statusCode}"

                        fi
                    
                    elif [[ ${domain} != *"FUZZ" ]] ; then
                        statusCode=$( curl -I -k -L ${domain}/${line} -s -o /dev/null -w "%{http_code}" )
                        if [[ ${statuscodes} ]] ; then
                            for status in ${statuscodes} ; do
                                if [[ ${status} -eq ${statusCode} ]] ; then
                                    echo -e "${domain}/${line}\t${statusCode}"
                                fi
                            done
                        else
                            echo -e "${domain}/${line}\t${statusCode}"
                        fi
                    fi
                done

            # if user does not use wordlist
            elif [[ ${word} ]] ; then
                for line in ${word} ; do
                    if [[ ${domain} == *"FUZZ" ]] ; then
                        statusCode=$( curl -I -k -L ${domain/FUZZ/$line} -s -o /dev/null -w "%{http_code}" )
                        if [[ ${statuscodes} ]] ; then
                            for status in ${statuscodes} ; do
                                if [[ ${status} -eq ${statusCode} ]] ; then
                                    echo -e "${domain/FUZZ/$line}\t${statusCode}"
                                fi
                            done
    
                        else
                            echo -e "${domain/FUZZ/$line}\t${statusCode}"
                        fi
                    
                    elif [[ ${domain} != *"FUZZ" ]] ; then
                        statusCode=$( curl -I -k -L ${domain}/${line} -s -o /dev/null -w "%{http_code}" )
                        if [[ ${statuscodes} ]] ; then
                            for status in ${statuscodes} ; do
                                if [[ ${status} -eq ${statusCode} ]] ; then
                                    echo -e "${domain}/${line}\t${statusCode}"
                                fi
                            done
                        else
                            echo -e "${domain}/${line}\t${statusCode}"
                        fi
                    fi
                done
            fi
        done
    fi

    echo ""
}

while getopts "d:D:w:W:s:h" opt ; do
    case $opt in
        h)
            echo ""
            echo -e "\t-h\tPrint this help menu and exit."
            echo -e "\t-d\tDomain(s) to scan. MultipleEx: \"https://example.com https://example2.com\""
            echo -e "\t-D\tDomain file with list of domains."
            echo -e "\t-w\tPath(s) to search or fuzz. MultipleEx: \"login.html login.php test/\""
            echo -e "\t-W\tWordlist file."
            echo -e "\t-s\tParse results by status codes."
            echo ""

            exit 0
            ;;
        d)
            domains+=( "$OPTARG" )
            ;;
        w)
            word+=( "$OPTARG" )
            ;;

        W)
            wordlist=$OPTARG
            ;;

        D)
            domainFile=$OPTARG
            ;;

        s)
            statuscodes+=( "$OPTARG" )
            ;;

    esac
done

shift $((OPTIND -1))

function main() {

    if [[ ${domains} && ${domainsFile} ]] ; then
        echo ""
        echo "[ ERROR ] Please use either -d (parse domain(s)) or -D (parse domain(s) from file)"
        echo ""

        exit 1
    
    elif [[ ${domains} ]] ; then
        fuzzDomains

    elif [[ ${domainsFile} ]] ; then
        fuzzDomainsFile

    else
        echo ""
        echo "[ ERROR ] There was an error in your syntax."
        echo ""
        echo -e "\t-h\tPrint this help menu and exit."
        echo -e "\t-d\tDomain(s) to scan. MultipleEx: \"https://example.com https://example2.com\""
        echo -e "\t-D\tDomain file with list of domains."
        echo -e "\t-w\tPath(s) to search or fuzz. MultipleEx: \"login.html login.php test/\""
        echo -e "\t-W\tWordlist file."
        echo -e "\t-s\tParse results by status codes."
        echo ""

        exit 1

    fi
}

main
