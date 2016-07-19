<div id="modal_add" class="popupContainer" style="display:none;">

    <section class="popupBody">
        <span class="header_title"></span>

        <!-- Social Login -->
        <div class="social_add">
            <div class="action_btns">
                <div class="one_third"><a href="add_prod.jsp" id="add_prod_form" class="btn"><i
                        class="fa fa-plus"></i><br/>Product</a>
                </div>
                <div class="one_third"><a href="#" id="add_cat_form" class="btn"><i class="fa fa-plus"></i><br/>Category</a>
                </div>
                <div class="one_third"><a href="#" id="add_man_form" class="btn"><i
                        class="fa fa-plus"></i><br/>Brand</a>
                </div>
            </div>
        </div>

        <!-- add cat form -->
        <div class="add_cat">
            <form>
                <label>Category name</label>
                <input type="text" name="cat_name" id="cat_name"/>
                <br/>

                <div class="action_btns">
                    <div class="one_half"><a href="#" class="btn add_back_btn"><i class="fa fa-angle-double-left"></i>
                        Back</a>
                    </div>
                    <div class="one_half last"><a href="#" id="add_cat_last" class="btn btn_red"><i
                            class="fa fa-plus"></i> Add</a></div>
                </div>
            </form>
        </div>

        <!-- add man form-->
        <div class="add_man">
            <form>
                <label>Brand name</label>
                <input type="text" name="man_name" id="man_name"/>
                <br/>

                <div class="action_btns">
                    <div class="one_half"><a href="#" class="btn add_back_btn"><i class="fa fa-angle-double-left"></i>
                        Back</a>
                    </div>
                    <div class="one_half last"><a href="#" id="add_man_last" class="btn btn_red"><i
                            class="fa fa-plus"></i> Add</a></div>
                </div>
            </form>
        </div>
    </section>

</div>
