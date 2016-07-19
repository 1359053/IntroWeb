<div id="modal_del" class="popupContainer" style="display:none;">

    <section class="popupBody">
        <span class="header_title"></span>

        <!-- Social Login -->
        <div class="social_del">
            <div class="action_btns">
                <div class="one_half"><a href="#" id="del_cat_form" class="btn"><i class="fa fa-trash"></i> Category</a>
                </div>
                <div class="one_half"><a href="#" id="del_man_form" class="btn"><i class="fa fa-trash"></i> Brand</a>
                </div>
            </div>
        </div>

        <!-- del cat form -->
        <div class="del_cat">
            <form>
                <label>Category name</label>
                <select id="cat_name_sel">
                    <option value="">Choose a category...</option>
                    <%= CategoryJspGui.toOption(CategoryDao.getAll()) %>
                </select>
                <br/>

                <div class="action_btns">
                    <div class="one_half"><a href="#" class="btn del_back_btn"><i class="fa fa-angle-double-left"></i>
                        Back</a>
                    </div>
                    <div class="one_half last"><a href="#" id="del_cat_last" class="btn btn_red"><i
                            class="fa fa-trash"></i> Delete</a></div>
                </div>
            </form>
        </div>

        <!-- del cat confirm -->
        <div class="del_cat_confirm">
            <label>All products in category <span id="del_cat_name"></span> will be delete.</label>
            <label>Are you sure?</label>
            <br/>

            <div class="action_btns">
                <div class="one_half"><a href="#" class="btn del_back_btn"><i class="fa fa-angle-double-left"></i> Back</a>
                </div>
                <div class="one_half last"><a href="#" id="del_cat_ok" class="btn btn_red"><i
                        class="fa fa-trash"></i> Delete</a></div>
            </div>
        </div>

        <!-- del man form-->
        <div class="del_man">
            <form>
                <label>Brand name</label>
                <select id="man_name_sel">
                    <option value="" selected>Choose a brand...</option>
                    <%= ManufacturerJspGui.toOption(ManufacturerDao.getAll()) %>
                </select>
                <br/>

                <div class="action_btns">
                    <div class="one_half"><a href="#" class="btn del_back_btn"><i class="fa fa-angle-double-left"></i>
                        Back</a>
                    </div>
                    <div class="one_half last"><a href="#" id="del_man_last" class="btn btn_red"><i
                            class="fa fa-trash"></i> Delete</a></div>
                </div>
            </form>
        </div>

        <!-- del man confirm -->
        <div class="del_man_confirm">
            <label>All products in brand <span id="del_man_name"></span> will be delete.</label>
            <label>Are you sure?</label>
            <br/>

            <div class="action_btns">
                <div class="one_half"><a href="#" class="btn del_back_btn"><i class="fa fa-angle-double-left"></i> Back</a>
                </div>
                <div class="one_half last"><a href="#" id="del_man_ok" class="btn btn_red"><i
                        class="fa fa-trash"></i> Delete</a></div>
            </div>
        </div>
    </section>

</div>
