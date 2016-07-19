<div id="modal" class="popupContainer" style="display:none;">

    <section class="popupBody">
        <span class="header_title"></span>

        <!-- Social Login -->
        <div class="social_login">
            <div class="action_btns">
                <div class="one_half"><a href="#" id="login_form" class="btn"><i class="fa fa-sign-in"></i> Login</a>
                </div>
                <div class="one_half last"><a href="#" id="register_form" class="btn"><i class="fa fa-user-plus"></i>
                    Register</a></div>
            </div>
        </div>

        <!-- Username & Password Login form -->
        <div class="user_login">
            <form>
                <label>Email</label>
                <input type="email" name="login_email" id="login_email" placeholder="Enter a valid email address" required/>
                <br/>

                <label>Password</label>
                <input type="password" name="login_password" id="login_password" placeholder="Enter your password"required/>
                <br/>

                <div class="checkbox">
                    <input id="remember" type="checkbox"/>
                    <label for="remember">Remember me on this computer</label>
                </div>

                <div class="action_btns">
                    <div class="one_half"><a href="#" class="btn back_btn"><i class="fa fa-angle-double-left"></i> Back</a>
                    </div>
                    <div class="one_half last"><a href="#" id="log_last" class="btn btn_red"><i
                            class="fa fa-sign-in"></i> Login</a></div>
                </div>
            </form>
        </div>

        <!-- Register Form 1-->
        <div class="user_register">
            <form>
                <label>Name <span id="check_name"></span></label>
                <input type="text" id="reg_name" placeholder="Enter your full name, not required"/>
                <br/>

                <label>Email <span id="check_email"></span></label>
                <input type="email" id="reg_email" placeholder="Enter a valid email address, required" required/>
                <br/>

                <label>Password <span id="check_password"></span></label>
                <input type="password" id="reg_password" placeholder="Enter your password, required" required/>
                <br/>

                <label>Confirm password <span id="check_match_password"></span></label>
                <input type="password" id="reg_confirm_password" placeholder="Enter your password again, required" required/>
                <br/>

                <div class="action_btns">
                    <div class="one_half"><a href="#" class="btn back_btn"><i class="fa fa-angle-double-left"></i> Back</a>
                    </div>
                    <div class="one_half last"><a href="#" class="btn btn_red" id="reg2">Continue <i
                            class="fa fa-angle-double-right"></i></a></div>
                </div>
            </form>
        </div>

        <!-- Register Form 2-->
        <div class="user_register2">
            <form>
                <label>Address <span id="check_address"></span></label>
                <input type="text" id="reg_address" placeholder="Enter your address, required" required/>
                <br/>

                <label>Phone number <span id="check_phone"></span></label>
                <input type="text" id="reg_phone" placeholder="Enter your phone number, required" required/>
                <br/>

                <div class="action_btns">
                    <div class="one_half"><a href="#" class="btn back_btn"><i class="fa fa-angle-double-left"></i> Back</a>
                    </div>
                    <div class="one_half last"><a href="#" id="reg_last" class="btn btn_red"><i
                            class="fa fa-user-plus"></i> Register</a></div>
                </div>
            </form>
        </div>
    </section>

</div>
