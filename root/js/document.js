
    var cfg = {};

    var letter = {
        date: 
            "15 March 2005",

        from:
            "5 Hill Street\n" +
            "Madison, Wisconsin 53700",

        to:
            "Ms. Helen Jones\n" +
            "President\n" +
            "Jones, Jones &amp; Jones\n" +
            "123 International Lane\n" +
            "Boston, Massachusetts 01234",

        salutation:
            "Dear Ms. Jones:",

        closing:
            "Sincerely,\n\n" +
            "John Doe",

        body: 
            "Ah, business letter format--there are block formats, and indented formats, and modified block formats . . . and who knows what others.  To simplify matters, we're demonstrating the indented format on this page, one of the two most common formats.  For authoritative advice about all the variations, we highly recommend <em>The Gregg Reference Manual</em>, 9th ed. (New York: McGraw-Hill, 2001), a great reference tool for workplace communications.  There seems to be no consensus about such fine points as whether to skip a line after your return address and before the date: some guidelines suggest that you do; others do not.  Let's hope that your business letter succeeds no matter which choice you make!" + "\n\n" +

            "If you are using the indented form, place your address at the top, with the left edge of the address aligned with the center of the page. Skip a line and type the date so that it lines up underneath your address.  Type the inside address and salutation flush left; the salutation should be followed by a colon. For formal letters, avoid abbreviations." + "\n\n" +

            "Indent the first line of each paragraph one-half inch. Skip lines between paragraphs." + "\n\n" +

            "Instead of placing the closing and signature lines flush left, type them in the center, even with the address and date above, as illustrated here. Now doesn't that look professional?"

    };

    function formatSmall( text ) {
        return text.replace( /\n/g, "<br/>" );
    }

    function formatBody( text ) {
        return "<p>" + text.replace( /\n\n+/g, "</p><p>" ) + "<p>";
    }

    function buildSmallComponent( name ) {
        var clss = ".ltr-" + name;
        $( clss ).html( formatSmall( letter[name] ) );
        $( clss ).editable(
            function( input ) {
                letter[name] = input;
                return formatSmall( input );
            }, {
                data: function() {
                    return letter[name]
                },
                submit: 'OK',
                cancel: 'Cancel',
                type: 'textarea',
                rows: '3'
            }
        );
    }

    function buildBodyComponent( name ) {
        var clss = ".ltr-" + name;
        $( clss ).html( formatBody( letter[name] ) );
        $( clss ).editable(
            function( input ) {
                letter[name] = input;
                return formatBody( input );
            }, {
                data: function() {
                    return letter[name]
                },
                submit: 'OK',
                cancel: 'Cancel',
                type: 'textarea',
                rows: '24'
            }
        );
    }

    function selectStyle( style ) {

        if ( style == "full" ) {
            $(".letter").removeClass("letter-fb letter-mb letter-ib").addClass("letter-fb");
        }
        else if ( style == "modified" ) {
            $(".letter").removeClass("letter-fb letter-mb letter-ib").addClass("letter-mb");
        }
        else if ( style == "indented" ) {
            $(".letter").removeClass("letter-fb letter-mb letter-ib").addClass("letter-ib");
        }
        else {
            return;
        }

        $( ".style-select" ).removeClass( "selected" );
        $( ".style-" + style ).addClass( "selected" );

        cfg.style = style;
    }

    function rtfSubmit( style ) {
    
        $("#rtf-form-style").val( style );
        $("#rtf-form-from").val( letter["from"] );
        $("#rtf-form-to").val( letter["to"] );
        $("#rtf-form-closing").val( letter["closing"] );
        $("#rtf-form-salutation").val( letter["salutation"] );
        $("#rtf-form-date").val( letter["date"] );
        $("#rtf-form-body").val( letter["body"] );
        $("#rtf-form").submit();
    }


    function initialize() {

        buildSmallComponent( "from" );
        buildSmallComponent( "date" );
        buildSmallComponent( "to" );
        buildSmallComponent( "salutation" );
        buildSmallComponent( "closing" );
        buildBodyComponent( "body" );
        selectStyle( "full" );

        $(".style-full").live( "click", function() {
            selectStyle( "full" );
        } );

        $(".style-modified").live( "click", function() {
            selectStyle( "modified" );
        } );

        $(".style-indented").live( "click", function() {
            selectStyle( "indented" );
        } );

        $(".download-rtf").live( "click", function() {
            rtfSubmit( cfg.style );
        } );
    }
