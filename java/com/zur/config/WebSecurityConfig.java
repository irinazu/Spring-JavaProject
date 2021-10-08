package com.zur.config;

import com.zur.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {
    @Autowired
    UserService userService;

    //кодирование пароля
    @Bean
    public BCryptPasswordEncoder bCryptPasswordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Override
    protected void configure(HttpSecurity httpSecurity) throws Exception {
        httpSecurity
                .csrf()
                    .disable()
                .authorizeRequests()
                    //для не зарегистрированных
                    .antMatchers("/registration").not().fullyAuthenticated()
                    //по ролям
                    .antMatchers("/admin/**","/update","/create","/orderStatus/**","/searchOrders/**","/searchOrdersId/**","/deleteComment").hasRole("ADMIN")
                    .antMatchers("/cart","/order","/cabinet","/item","/cabinet/**","/createComment","/mycomments","/like","/alllike").hasRole("USER")
                    //для всех пользователей
                    .antMatchers("/", "/resources/**","/index","/page/**","/category/**","/search/**","/newac","/item").permitAll()
                //все остальные страницы требуют аутентификации
                .anyRequest().authenticated()
                .and()
                    //для входа в систему
                    .formLogin()
                    .loginPage("/login")
                    //Перенарпавление на главную страницу после успешного входа
                    .defaultSuccessUrl("/")
                    .permitAll()
                .and()
                //Перенарпавление на главную страницу после успешного выхода
                    .logout()
                    .permitAll()
                    .logoutSuccessUrl("/");
    }

    //работа с пользователями
    @Autowired
    protected void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userService).passwordEncoder(bCryptPasswordEncoder());
    }
}
