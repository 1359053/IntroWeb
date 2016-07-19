<html>
<input type="text" id="old_key" value="${loggedUser.password}" disabled hidden/>
<div id="modal_acc" class="popupContainer" style="display:none;">

    <section class="popupBody">
        <span class="header_title"></span>

        <!-- Social Account -->
        <div class="social_acc">
            <label>Name</label>
            <input type="text" id="old_name" value="${loggedUser.name}" disabled/>
            <br/>

            <label>Email</label>
            <input type="email" id="old_email" value="${loggedUser.id}" disabled/>
            <br/>

            <label>Address</label>
            <input type="text" id="old_add" value="${loggedUser.address}" disabled/>
            <br/>

            <label>Phone number</label>
            <input type="text" id="old_phone" value="${loggedUser.phone}" disabled/>
            <br/>
            <div class="action_btns">
                <div class="one_half"><a href="#" id="info_form" class="btn"><i class="fa fa-pencil"></i> Info</a>
                </div>
                <div class="one_half last"><a href="#" id="pass_form" class="btn"><i class="fa fa-pencil"></i>
                    Password</a></div>
            </div>
        </div>

        <!-- Edit Info -->
        <div class="info_acc">
            <label>Name</label>
            <input type="text" id="info_name" value="${loggedUser.name}"/>
            <br/>

            <label>Address <span id="chk_add"></span></label>
            <input type="text" id="info_add" value="${loggedUser.address}"/>
            <br/>

            <label>Phone number <span id="chk_phone"></span></label>
            <input type="text" id="info_phone" value="${loggedUser.phone}"/>
            <br/>

            <div class="action_btns">
                <div class="one_half"><a href="#" class="btn back_btn"><i class="fa fa-angle-double-left"></i> Back</a>
                </div>
                <div class="one_half last"><a href="#" id="info_ok" class="btn btn_red"><i
                        class="fa fa-cloud-upload"></i> Update</a></div>
            </div>
        </div>

        <!-- Change Pass -->
        <div class="pass_acc">
            <label>Old Password <span id="chk_old_pass"></span></label>
            <input type="password" id="old_pass" placeholder="Enter your old password, required" required/>
            <br/>

            <label>New Password <span id="chk_new_pass"></span></label>
            <input type="password" id="new_pass" placeholder="Enter your new password, required" required/>
            <br/>

            <label>Confirm new password <span id="chk_new_pass_con"></span></label>
            <input type="password" id="new_pass_con" placeholder="Enter your new password again, required" required/>
            <br/>

            <div class="action_btns">
                <div class="one_half"><a href="#" class="btn back_btn"><i class="fa fa-angle-double-left"></i> Back</a>
                </div>
                <div class="one_half last"><a href="#" id="pass_ok" class="btn btn_red"><i
                        class="fa fa-cloud-upload"></i> Update</a></div>
            </div>
        </div>
    </section>

</div>
</html>