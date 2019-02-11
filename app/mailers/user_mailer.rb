class UserMailer < ApplicationMailer
  default from: 'no-reply@eventproject.fr'

  def welcome_email(user)
    #on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
    @user = user

    #on définit une variable @url qu'on utilisera dans la view d’e-mail
    @url  = 'http://eventproject.fr/login'

    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @user.email, subject: 'Bienvenue chez nous !')
  end

  def new_attendee_email(attendance)
    #on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
    @attendance = attendance
    @user = attendance.event.admin
    @event = attendance.event

    #on définit une variable @url qu'on utilisera dans la view d’e-mail
    @url  = 'http://eventproject.fr/login'

    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @user.email, subject: 'Nouvel inscrit')
  end
end
